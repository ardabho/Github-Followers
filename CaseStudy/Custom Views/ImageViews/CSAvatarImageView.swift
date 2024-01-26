//
//  CSAvatarImageView.swift
//  CaseStudy
//
//  Created by ARDA BUYUKHATIPOGLU on 9.01.2024.
//

import UIKit

class CSAvatarImageView: UIImageView {
    let cache = NetworkManager.shared.cache
    let placeholderImage = Images.avatarPlaceholder
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
    }
    
    func downloadImage(from urlString: String) {
        NetworkManager.shared.downloadImage(from: urlString) { image in
            guard let image = image else {return}
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }

}
