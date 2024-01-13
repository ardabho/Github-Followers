//
//  PersistanceManager.swift
//  CaseStudy
//
//  Created by ARDA BUYUKHATIPOGLU on 12.01.2024.
//

import Foundation

enum PersistanceActionType {
    case add, remove
}

struct PersistanceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favourites = "favourites"
    }
    
    
    static func update(with favourite: Follower, actionType: PersistanceActionType, completed: @escaping (CSError?) -> Void) {
        retrieveFavourites { result in
            switch result {
            case .success(let favourites):
                var retrievedFavourites = favourites
                
                switch actionType {
                case .add:
                    guard !retrievedFavourites.contains(favourite) else {
                        completed(.alreadyInFavourites)
                        return
                    }
                    
                    retrievedFavourites.append(favourite)
                    
                case .remove:
                    retrievedFavourites.removeAll {$0.login == favourite.login}
                }
                
                completed(save(favourites: retrievedFavourites))
                
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    static func retrieveFavourites(completed: @escaping (Result<[Follower], CSError>) -> Void) {
        guard let favouritesData = defaults.object(forKey: Keys.favourites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favourites = try decoder.decode([Follower].self, from: favouritesData)
            completed(.success(favourites))
        } catch {
            completed(.failure(.unableToFavourite))
        }
    }
    
    
    static func save(favourites: [Follower]) -> CSError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavourites = try encoder.encode(favourites)
            defaults.setValue(encodedFavourites, forKey: Keys.favourites)
            return nil
        } catch {
            return CSError.unableToFavourite
        }
    }
    
}
