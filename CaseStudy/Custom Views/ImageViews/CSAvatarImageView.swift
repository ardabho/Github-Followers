//
//  CSAvatarImageView.swift
//  CaseStudy
//
//  Created by ARDA BUYUKHATIPOGLU on 9.01.2024.
//

import UIKit

class CSAvatarImageView: UIImageView {
    let cache = NetworkManager.shared.cache
    let placeholderImage = UIImage(named: "avatar-placeholder")
    
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
    
    /// Download the image and set it as imageviews image. Caches the image after download.
    /// If the Image is already cached, automatically sets the image with the cached one.
    /// - Parameter urlString: URL String for the image to be downloaded
    func downloadImage(from urlString: String) {
        let cackeKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cackeKey) {
            self.image = image
            return
        }

        guard let url = URL(string: urlString) else { return }
                
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            cache.setObject(image, forKey: cackeKey)
            
            DispatchQueue.main.async { self.image = image }
        }
        task.resume()
    }

}
