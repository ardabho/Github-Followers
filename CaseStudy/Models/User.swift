//
//  User.swift
//  CaseStudy
//
//  Created by ARDA BUYUKHATIPOGLU on 9.01.2024.
//

import Foundation

struct User: Codable {
    let login: String
    let avatarUrl: String
    let name: String?
    let location: String?
    let bio: String?
    let publicRepos: Int
    let publicGists: Int
    let followers: Int
    let following: Int
    let htmlUrl: String
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case login, avatarUrl = "avatar_url", name, location,
             bio, publicRepos = "public_repos", publicGists = "public_gists",
             followers, following, htmlUrl = "html_url", createdAt = "created_at"
        
    }
}
