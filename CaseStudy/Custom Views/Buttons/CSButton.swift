//
//  CSButton.swift
//  CaseStudy
//
//  Created by ARDA BUYUKHATIPOGLU on 6.01.2024.
//

import UIKit

class CSButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        titleLabel?.font = .preferredFont(forTextStyle: .headline)
        setTitleColor(.white, for: .normal)
        
    }
    
    
    func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
}
