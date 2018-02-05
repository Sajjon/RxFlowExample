//
//  ProfileViewController.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-05.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import UIKit
import RxFlow
import RxSwift
import RxCocoa
import ViewComposer
import TinyConstraints

final class ProfileViewController: UIViewController {

    lazy var emailLabel: UILabel =  UILabel()
    lazy var nameLabel: UILabel = UILabel()
    
    lazy var stackView: UIStackView = stackViewStyle <- .views([self.emailLabel, self.nameLabel, .spacer])
    
    let viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBindings()
    }
}

private extension ProfileViewController {
    
    func setupBindings() {
        viewModel.email
            .bind(to: emailLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.name
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func setupViews() {
        title = "Profile"
        view.backgroundColor = .brown
        view.addSubview(stackView)
        stackView.edgesToSuperview()
    }
}

