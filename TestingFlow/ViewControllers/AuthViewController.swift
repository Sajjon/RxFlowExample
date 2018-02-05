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
import RxSwift
import ViewComposer
import TinyConstraints

extension UIView {
    static var spacer: UIView {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return view
    }
}

final class AuthViewController: UIViewController {
    
    lazy var signUpButton: UIButton = buttonStyle <<- [.text("Sign Up"), .color(.blue)]
    lazy var signInButton: UIButton = buttonStyle <- .text("Sign In")
    
    lazy var stackView: UIStackView = stackViewStyle <- .views([self.signUpButton, self.signInButton, .spacer])
    
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
        title = "Welcome"
        
        view.addSubview(stackView)
        stackView.edgesToSuperview()
    }
}
