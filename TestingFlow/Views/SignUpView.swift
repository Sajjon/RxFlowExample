//
//  SignInView.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-06.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import UIKit
import ViewComposer
import TinyConstraints

final class SignUpView: UIView {
    
    lazy var emailField: UITextField = fieldStyle <- .placeholder("Email")
    lazy var passwordField: UITextField = fieldStyle <<- [.placeholder("Password"), .isSecureTextEntry(true)]
    lazy var signUpButton: UIButton = buttonStyle <<- [.text("Sign Up"), .color(.blue)]
    lazy var stackView: UIStackView = stackViewStyle <- .views([self.emailField, self.passwordField, self.signUpButton, .spacer])
    
    init() {
        super.init(frame: .zero)
        addSubview(stackView)
        stackView.edgesToSuperview()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
}
