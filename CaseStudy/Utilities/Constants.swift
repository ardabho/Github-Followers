//
//  Constants.swift
//  CaseStudy
//
//  Created by ARDA BUYUKHATIPOGLU on 11.01.2024.
//

import UIKit

enum SFSymbols {
    static let location     = "mappin.and.ellipse"
    static let repos        = "folder"
    static let gists        = "text.alignleft"
    static let followers    = "heart"
    static let following    = "person.2"
}

enum Images {
    static let ghLogo = UIImage(named: "gh-logo")
    static let emptyState = UIImage(named: "empty-state-logo")
    static let avatarPlaceholder = UIImage(named: "avatar-placeholder")
    static let location = UIImage(systemName: SFSymbols.location)
    static let repos = UIImage(systemName: SFSymbols.repos)
    static let gists = UIImage(systemName: SFSymbols.gists)
    static let followers = UIImage(systemName: SFSymbols.followers)
    static let following = UIImage(systemName: SFSymbols.following)
}

enum ScreenSize {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
    static let maxLength = max(ScreenSize.width, ScreenSize.height)
    static let minLength = min(ScreenSize.width, ScreenSize.height)
}


enum DeviceTypes {
    static let idiom = UIDevice.current.userInterfaceIdiom
    static let nativeScale = UIScreen.main.nativeScale
    static let scale = UIScreen.main.scale
    
    static let isiphoneSE               = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isiphone8Standard        = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiphone8Zoomed          = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiphone8PlusStandard    = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiphone8PlusZoomed      = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isiphoneX                = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiphoneXsMaxAndXr       = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPad                   = idiom == .pad && ScreenSize.maxLength >= 1024.0
    
    static func isiPhoneXAspectRatio() -> Bool {
        return isiphoneX || isiphoneXsMaxAndXr
    }
}
