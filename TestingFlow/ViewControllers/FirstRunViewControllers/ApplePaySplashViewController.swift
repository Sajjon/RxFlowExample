//
//  ApplePaySplashViewController.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-05.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import UIKit
import PassKit
import ViewComposer
import TinyConstraints

final class ApplePaySplashViewController: UIViewController {
    private lazy var setupApplePayButton: PKPaymentButton = {
        let button = PKPaymentButton(paymentButtonType: .setUp, paymentButtonStyle: .black)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let viewModel: ApplePaySpashViewModel
    
    init(viewModel: ApplePaySpashViewModel) {
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

private extension ApplePaySplashViewController {
    
    func setupBindings() {
        
        setupApplePayButton.rx.tap
            .bind(to: viewModel.input.setup)
            .disposed(by: disposeBag)
    }
    
    func setupViews() {
        title = "Now accepting Apple Pay"
        view.backgroundColor = .white
        
        view.addSubview(setupApplePayButton)
        setupApplePayButton.centerInSuperview()
        setupApplePayButton.height(50)
        setupApplePayButton.width(100)
    }
}
