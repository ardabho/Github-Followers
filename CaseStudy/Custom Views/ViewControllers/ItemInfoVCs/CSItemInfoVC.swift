//
//  CSItemInfoVC.swift
//  CaseStudy
//
//  Created by ARDA BUYUKHATIPOGLU on 12.01.2024.
//

import UIKit

protocol ItemInfoVCDelegate: AnyObject {
    func didTapGetFollowers()
    func didTapGithubProfile()
}

class CSItemInfoVC: UIViewController {

    let stackview = UIStackView()
    let infoViewOne = CSItemInfoView()
    let infoViewTwo = CSItemInfoView()
    let actionButton = CSButton()
    
    var user: User!
    var delegate: ItemInfoVCDelegate!
    
    
    init(user: User!) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        configureActionButton()
        layoutUI()
        configureStackView()
    }
    
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    
    private func configureStackView() {
        stackview.axis = .horizontal
        stackview.distribution = .equalSpacing
        
        stackview.addArrangedSubview(infoViewOne)
        stackview.addArrangedSubview(infoViewTwo)
    }
    
    
    private func configureActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    
    @objc func actionButtonTapped() { }
    
    
    private func layoutUI() {
        view.addSubview(stackview)
        view.addSubview(actionButton)
        
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackview.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackview.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.topAnchor.constraint(equalTo: stackview.bottomAnchor, constant: 14),
            actionButton.leadingAnchor.constraint(equalTo: stackview.leadingAnchor),
            actionButton.trailingAnchor.constraint(equalTo: stackview.trailingAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

}
