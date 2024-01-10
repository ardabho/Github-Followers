//
//  UIViewController+Ext.swift
//  CaseStudy
//
//  Created by ARDA BUYUKHATIPOGLU on 8.01.2024.
//

import UIKit

extension UIViewController {
    
    func presentCSAlertOnMainThread(alertTitle: String, alertMessage: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = CSAlertVC(alertTitle: alertTitle, message: alertMessage, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
