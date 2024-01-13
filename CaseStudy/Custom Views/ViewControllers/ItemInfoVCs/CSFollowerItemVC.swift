//
//  CSFollowerItemVC.swift
//  CaseStudy
//
//  Created by ARDA BUYUKHATIPOGLU on 12.01.2024.
//

import UIKit

class CSFollowerItemVC: CSItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    
    private func configureItems() {
        infoViewOne.setInfoType(to: .followers, withCount: user.followers)
        infoViewTwo.setInfoType(to: .following, withCount: user.following)
        
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
