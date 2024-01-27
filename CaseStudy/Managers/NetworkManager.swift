//
//  NetworkManager.swift
//  CaseStudy
//
//  Created by ARDA BUYUKHATIPOGLU on 9.01.2024.
//

import UIKit

class NetworkManager {
    
    static let shared          = NetworkManager()
    let cache                  = NSCache<NSString, UIImage>()
    private let baseurl        = "https://api.github.com/users/"
    private let resultsPerPage = 100
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], CSError>) -> Void) {
        let endpoint = baseurl + "\(username)/followers?per_page=\(resultsPerPage)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
                
            } catch {
                completed(.failure(.invalidData))
                return
            }
        }
        
        task.resume()
    }
    
    
    func getUser(for username: String, completed: @escaping (Result<User, CSError>) -> Void) {
        let endpoint = baseurl + "\(username)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
                
            } catch {
                completed(.failure(.invalidData))
                return
            }
        }
        
        task.resume()
    }
    
    /// Download the image and return the image. Caches the image after download.
    /// If the Image is already cached, automatically returns  cached image.
    /// - Parameter urlString: URL String for the image to be downloaded
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cackeKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cackeKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }

            cache.setObject(image, forKey: cackeKey)
            completed(image)
        }
        task.resume()
    }
}




