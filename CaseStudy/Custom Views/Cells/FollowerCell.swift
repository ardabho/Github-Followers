//
//  FollowerCell.swift
//  CaseStudy
//
//  Created by ARDA BUYUKHATIPOGLU on 9.01.2024.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    static let reuseIdentifier = "FollowerCell"
    
    let avatarImageView = CSAvatarImageView(frame: .zero)
    let usernameLabel = CSTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        usernameLabel.text = follower.login
        avatarImageView.downloadImage(from: follower.avatarUrl)
    }
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        let padding: CGFloat = 8
        
        if #available(iOS 15.0, *) {
            NSLayoutConstraint.activate([
                avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
                avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
                avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
                avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
                
                usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
                usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
                usernameLabel.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor),
                usernameLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        } else {
            NSLayoutConstraint.activate([
                avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
                avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
                avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
                
                usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
                usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
                usernameLabel.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor),
                usernameLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        }
    }
}
