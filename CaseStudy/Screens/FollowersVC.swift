//
//  FollowersVC.swift
//  CaseStudy
//
//  Created by ARDA BUYUKHATIPOGLU on 7.01.2024.
//

import UIKit

class FollowersVC: UIViewController {
    
    enum Section { case main }
    
    var username: String!
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var hasMoreFollowers = true // Does the user have more followers to load?
    var page = 1
    var isSearchning = false // Indicates if the user is currently using search
    var isLoadingMoreFollowers = false
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(for: username, page: page)
        configureDataSource()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem =   addButton
    }
    
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
//        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseIdentifier)
    }
    
    
    private func getFollowers(for username: String, page: Int) {
        showLoadingView()
        isLoadingMoreFollowers = true
        
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            
            dismissLoadingView()
            
            switch result {
            case .success(let followers):
                self.updateUI(with: followers)
                
            case .failure(let error):
                self.presentCSAlertOnMainThread(alertTitle: "Bad Stuff", alertMessage: error.rawValue, buttonTitle: "Ok")
            }
            
            self.isLoadingMoreFollowers = false
        }
    }
    
    
    func updateUI(with followers: [Follower]) {
        if followers.count < 100 { self.hasMoreFollowers = false }
        self.followers.append(contentsOf: followers)
        
        if self.followers.isEmpty {
            let message = "This user doesn't have any followers. Go follow them 😄."
            DispatchQueue.main.async {
                self.navigationItem.searchController?.isActive = false
                self.showEmptyStateView(with: message, in: self.view) }
            return
        }
        
        self.updateData(on: self.followers)
    }
    
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseIdentifier, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    
    private func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    
    @objc func addButtonTapped() {
        showLoadingView()
        
        NetworkManager.shared.getUser(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                self.addUserToFavourites(user: user)
                
            case .failure(let error):
                self.presentCSAlertOnMainThread(alertTitle: "Something Went Wrong", alertMessage: error.rawValue , buttonTitle: "Ok")
            }
        }
    }
    
    
    func addUserToFavourites(user: User) {
        let favourite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        PersistanceManager.update(with: favourite, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            
            if let error = error {
                self.presentCSAlertOnMainThread(alertTitle: "Something Went Wrong", alertMessage: error.rawValue, buttonTitle: "Ok")
                return
            }
            
            self.presentCSAlertOnMainThread(alertTitle: "Success", alertMessage: "You have succesfully added this user to your favourites 🎉", buttonTitle: "Ok")
        }
    }
}


extension FollowersVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
            page += 1
            getFollowers(for: username, page: page)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearchning ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        
        let destinationVC = UserInfoVC()
        destinationVC.username = follower.login
        destinationVC.delegate = self
        
        let navController = UINavigationController(rootViewController: destinationVC)
        present(navController, animated: true)
    }
}


extension FollowersVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            updateData(on: followers)
            filteredFollowers.removeAll()
            isSearchning = false
            return
        }
        
        isSearchning = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }
    
}

extension FollowersVC: UserInfoVCDelegate {
    
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        page = 1
        isSearchning = false
        hasMoreFollowers = true
        navigationItem.searchController?.searchBar.text = ""
        navigationItem.searchController?.isActive = false
        getFollowers(for: username, page: page)
        
    }
    
}

