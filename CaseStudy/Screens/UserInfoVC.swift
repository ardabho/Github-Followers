//
//  UserInfoVC.swift
//  CaseStudy
//
//  Created by ARDA BUYUKHATIPOGLU on 11.01.2024.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class UserInfoVC: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = CSBodyLabel(textAlignment: .center)
    
    var username: String!
    
    weak var delegate: UserInfoVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        layoutUI()
        getUser()
    }
    
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = username
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem =   doneButton
    }
    
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)
        ])
        
    }
    
    private func getUser() {
        NetworkManager.shared.getUser(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.configureUIElements(with: user) }
            case .failure(let error):
                presentCSAlertOnMainThread(alertTitle: "Bad Stuff", alertMessage: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    func configureUIElements(with user: User) {
        let repoItemVC = CSRepoItemVC(user: user)
        let followerItemVC = CSFollowerItemVC(user: user)
        
        repoItemVC.delegate = self
        followerItemVC.delegate = self
        
        self.add(childVC: CSUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.dateLabel.text = "GitHub since " + user.createdAt.convertToMonthYearFormat()
    }
    
    
    private func layoutUI() {
        contentView.addSubviews(headerView, itemViewOne, itemViewTwo, dateLabel)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        itemViewOne.translatesAutoresizingMaskIntoConstraints = false
        itemViewTwo.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            itemViewOne.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            itemViewTwo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: itemViewTwo.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: itemViewTwo.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
}

extension UserInfoVC: ItemInfoVCDelegate {
    
    func didTapGithubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentCSAlertOnMainThread(alertTitle: "Invalid Url", alertMessage: "The URL attachted to this user is invalid", buttonTitle: "Ok")
            return
        }
        
        presentSafariVC(with: url)
    }
    
    
    func didTapGetFollowers(for user: User) {
        guard user.followers > 0 else {
            presentCSAlertOnMainThread(alertTitle: "Oops", alertMessage: "This user has no followers 😞.", buttonTitle: "So Sad")
            return
        }
        
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
    
}
