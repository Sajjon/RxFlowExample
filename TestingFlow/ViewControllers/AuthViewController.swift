//
//  AuthViewController.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-01.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import UIKit
import RxSwift
import RxFlow

final class AuthViewController: UIViewController {
    
    lazy var signUpButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Sign up", for: .normal)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var signInButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Sign in", for: .normal)
        button.backgroundColor = .green
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var stackView: UIStackView = UIStackView(arrangedSubviews: [self.signUpButton, self.signInButton])
    
    let viewModel: AuthViewModel
    
    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupBindings()
    }
}

private extension AuthViewController {
    
    func setupBindings() {
        signUpButton.rx.tap
            .bind(to: viewModel.input.signUp)
            .disposed(by: disposeBag)
        
        signInButton.rx.tap
            .bind(to: viewModel.input.signIn)
            .disposed(by: disposeBag)
    }
    
    func setupViews() {
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
