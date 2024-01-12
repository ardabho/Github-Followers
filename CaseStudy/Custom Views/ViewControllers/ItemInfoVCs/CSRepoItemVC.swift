//
//  CSRepoItemVC.swift
//  CaseStudy
//
//  Created by ARDA BUYUKHATIPOGLU on 12.01.2024.
//

import UIKit

class CSRepoItemVC: CSItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    
    private func configureItems() {
        infoViewOne.setInfoType(to: .repos, withCount: user.publicRepos)
        infoViewTwo.setInfoType(to: .gists, withCount: user.publicGists)
        
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    
    override func actionButtonTapped() {
        delegate.didTapGithubProfile()
    }
}

