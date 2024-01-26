//
//  UIView+Ext.swift
//  CaseStudy
//
//  Created by ARDA BUYUKHATIPOGLU on 26.01.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
