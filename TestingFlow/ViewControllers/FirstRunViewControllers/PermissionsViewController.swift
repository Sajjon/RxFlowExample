//
//  PermissionsViewController.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-06.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import UIKit
import ViewComposer
import TinyConstraints
import RxSwift

final class PermissionsViewController: UIViewController {
    private lazy var nextButton: UIButton = buttonStyle <<- [.text("Enable push notifications"), .textColor(.black)]
    private lazy var stackView: UIStackView = stackViewStyle <- .views([self.nextButton, .spacer])
    
    private let viewModel: PermissionsViewModel
    init(viewModel: PermissionsViewModel) {
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

private extension PermissionsViewController {
    
    func setupBindings() {
        
        nextButton.rx.tap
            .bind(to: viewModel.input.setup)
            .disposed(by: disposeBag)
    }
    
    func setupViews() {
        title = "Enable push notifications"
        view.backgroundColor = .white
        
        view.addSubview(stackView)
        stackView.edgesToSuperview()
    }
}
