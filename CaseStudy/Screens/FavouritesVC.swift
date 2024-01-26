//
//  FavouritesVC.swift
//  CaseStudy
//
//  Created by ARDA BUYUKHATIPOGLU on 6.01.2024.
//

import UIKit

class FavouritesVC: UIViewController {
    
    let tableview = UITableView()
    var favourites: [Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavourites()
    }
    
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favourites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func configureTableView() {
        view.addSubview(tableview)
        tableview.frame = view.bounds
        tableview.rowHeight = 80
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.register(FavouritesCell.self, forCellReuseIdentifier: FavouritesCell.reuseIdentifier)
    }
    
    
    private func getFavourites() {
        PersistanceManager.retrieveFavourites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favourites):
                if favourites.isEmpty {
                    showEmptyStateView(with: "You haven't added anyone to your favorites 🫥", in: view)
                } else {
                    self.favourites = favourites
                    DispatchQueue.main.async {
                        self.tableview.reloadData()
                        self.view.bringSubviewToFront(self.tableview)
                    }
                }
                
            case .failure(let error):
                self.presentCSAlertOnMainThread(alertTitle: "Unable To Remove", alertMessage: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}


extension FavouritesVC: UITableViewDataSource, UITableViewDelegate {
    //DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavouritesCell.reuseIdentifier, for: indexPath) as? FavouritesCell else {
            return UITableViewCell()
        }
        cell.set(favourite: favourites[indexPath.row])
        return cell
    }
    
    
    //Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favourite = favourites[indexPath.row]
        let destVC = FollowersVC(username: favourite.login)
        
        navigationController?.pushViewController(destVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let favourite = favourites[indexPath.row]
        favourites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .top)
        
        PersistanceManager.update(with: favourite, actionType: .remove) { [weak self] error in
            guard let self = self,
                  let error = error else { return }
            
            self.presentCSAlertOnMainThread(alertTitle: "Something Wrong", alertMessage: error.rawValue, buttonTitle: "Ok")
        }
    }
}
