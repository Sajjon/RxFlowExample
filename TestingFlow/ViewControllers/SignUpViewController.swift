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

    private lazy var signUpView = SignUpView()
    private let viewModel: SignUpViewModel
    
    init(viewModel: SignUpViewModel) {
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

private extension SignUpViewController {
    
    func setupBindings() {
        signUpView.emailField.rx.text.orEmpty
            .bind(to: viewModel.input.email)
            .disposed(by: disposeBag)
        
        signUpView.passwordField.rx.text.orEmpty
            .bind(to: viewModel.input.password)
            .disposed(by: disposeBag)
        
        signUpView.signUpButton.rx.tap
            .bind(to: viewModel.input.signUp)
            .disposed(by: disposeBag)
    }
    
    func setupViews() {
        title = "Sign Up"
        view.backgroundColor = .white
        
        view.addSubview(signUpView)
        signUpView.edgesToSuperview()
    }
}
