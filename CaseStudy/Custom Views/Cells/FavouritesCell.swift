//
//  FavouritesCell.swift
//  CaseStudy
//
//  Created by ARDA BUYUKHATIPOGLU on 13.01.2024.
//

import UIKit

class FavouritesCell: UITableViewCell {

    static let reuseIdentifier = "FavouritesCell"
    
    let avatarImageView = CSAvatarImageView(frame: .zero)
    let usernameLabel = CSTitleLabel(textAlignment: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favourite: Follower) {
        usernameLabel.text = favourite.login
        avatarImageView.downloadImage(from: favourite.avatarUrl)
    }
    
    private func configure() {
        addSubviews(avatarImageView, usernameLabel)
        
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        
        if #available(iOS 15.0, *){
            NSLayoutConstraint.activate([
                avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
                avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
                avatarImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
                avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor),
                
                usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
                usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
                usernameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
                avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                avatarImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
                avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor),
                
                usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
                usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
                usernameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
            ])
        }
    }
    
}
