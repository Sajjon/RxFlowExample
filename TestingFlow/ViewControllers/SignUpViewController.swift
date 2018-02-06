//
//  SignUpViewController.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-01.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import UIKit
import RxSwift
import ViewComposer
import TinyConstraints

final class SignUpViewController: UIViewController {
    
    private lazy var emailField: UITextField = fieldStyle <- .placeholder("Email")
    private lazy var passwordField: UITextField = fieldStyle <<- [.placeholder("Password"), .isSecureTextEntry(true)]
    private lazy var signUpButton: UIButton = buttonStyle <<- [.text("Sign Up"), .color(.blue)]
    private lazy var stackView: UIStackView = stackViewStyle <- .views([self.emailField, self.passwordField, self.signUpButton, .spacer])
    
    private let viewModel: SignUpViewModel
    
    init(viewModel: SignUpViewModel) {
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

private extension SignUpViewController {
    
    func setupBindings() {
        
        emailField.rx.text.orEmpty
            .bind(to: viewModel.input.email)
            .disposed(by: disposeBag)
        
        passwordField.rx.text.orEmpty
            .bind(to: viewModel.input.password)
            .disposed(by: disposeBag)
        
        signUpButton.rx.tap
            .bind(to: viewModel.input.signUp)
            .disposed(by: disposeBag)
    }
    
    func setupViews() {
        title = "Sign Up"
        view.addSubview(stackView)
        stackView.edgesToSuperview()
    }
}
