//
//  CSUserInfoHeaderVC.swift
//  CaseStudy
//
//  Created by ARDA BUYUKHATIPOGLU on 11.01.2024.
//

import UIKit

class CSUserInfoHeaderVC: UIViewController {

    let avatarImageView = CSAvatarImageView(frame: .zero)
    let usernameLabel = CSTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel = CSSecondaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel = CSSecondaryTitleLabel(fontSize: 18)
    let bioLabel = CSBodyLabel(textAlignment: .left)
    
    var user: User!
        
    let padding: CGFloat = 20
    let imageTextPadding: CGFloat = 12 //Padding between avatar and labels on right
    
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAvatarImage()
        configureUsernameLabel()
        configureNameLabel()
        configureLocationImageView()
        configureLocationLabel()
        configureBioLabel()
    }
    
    
    private func configureAvatarImage() {
        view.addSubview(avatarImageView)
        avatarImageView.downloadImage(from: user.avatarUrl)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    
    private func configureUsernameLabel() {
        view.addSubview(usernameLabel)
        usernameLabel.text = user.login
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: imageTextPadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
    
    
    private func configureNameLabel() {
        view.addSubview(nameLabel)
        nameLabel.text = user.name ?? "No Name Available"
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    
    private func configureLocationImageView() {
        view.addSubview(locationImageView)
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        locationImageView.image = UIImage(systemName: SFSymbols.location)
        locationImageView.tintColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            locationImageView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    
    private func configureLocationLabel() {
        view.addSubview(locationLabel)
        locationLabel.text = user.location ?? "No Location Available"
        
        NSLayoutConstraint.activate([
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            locationLabel.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    
    private func configureBioLabel() {
        view.addSubview(bioLabel)
        bioLabel.text = user.bio ?? "No Bio Available"
        bioLabel.numberOfLines = 3
        
        NSLayoutConstraint.activate([
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: imageTextPadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
