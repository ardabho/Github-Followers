//
//  NetworkManager.swift
//  CaseStudy
//
//  Created by ARDA BUYUKHATIPOGLU on 9.01.2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseurl =  "https://api.github.com/users/"
    private let resultsPerPage = 100
    
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
}




