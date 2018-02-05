//
//  SignInViewController.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-01.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import UIKit
import RxFlow
import RxSwift
import ViewComposer
import TinyConstraints

let stackViewStyle: ViewStyle = [.axis(.vertical), .spacing(16), .margin(16)]
let itemStyle: ViewStyle = [.height(50)]
let fieldStyle: ViewStyle = itemStyle <<- [.borderColor(.gray), .borderWidth(1)]
let buttonStyle: ViewStyle = itemStyle <<- [.color(.green)]
final class SignInViewController: UIViewController {
    
    lazy var emailField: UITextField = fieldStyle <- .placeholder("Email")
    lazy var passwordField: UITextField = fieldStyle <<- [.placeholder("Password"), .isSecureTextEntry(true)]
    lazy var signInButton: UIButton = buttonStyle <- .text("Sign In")
    
    lazy var stackView: UIStackView = stackViewStyle <- .views([self.emailField, self.passwordField, self.signInButton, .spacer])
    
    let viewModel: SignInViewModel
    
    init(viewModel: SignInViewModel) {
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

private extension SignInViewController {
    
    func setupBindings() {
        
        emailField.rx.text.orEmpty
            .bind(to: viewModel.input.email)
            .disposed(by: disposeBag)
        
        passwordField.rx.text.orEmpty
            .bind(to: viewModel.input.password)
            .disposed(by: disposeBag)
        
        signInButton.rx.tap
            .bind(to: viewModel.input.signIn)
            .disposed(by: disposeBag)
    }
    
    func setupViews() {
        title = "Sign In"
        view.backgroundColor = .white

        view.addSubview(stackView)
        stackView.edgesToSuperview()
    }
}
