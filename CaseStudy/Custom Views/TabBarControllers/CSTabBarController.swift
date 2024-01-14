//
//  CSTabBarController.swift
//  CaseStudy
//
//  Created by ARDA BUYUKHATIPOGLU on 13.01.2024.
//

import UIKit

class CSTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNC(), createFavouritesNC()]

        
    }
    
    
    func createSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    
    func createFavouritesNC() -> UINavigationController {
        let favouritesVC = FavouritesVC()
        favouritesVC.title = "Favourites"
        favouritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favouritesVC)
    }
}
