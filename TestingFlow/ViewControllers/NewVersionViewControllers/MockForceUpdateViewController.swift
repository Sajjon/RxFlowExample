//
//  MockForceUpdateViewController.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-06.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import UIKit
import ViewComposer
import TinyConstraints

final class MockForceUpdateViewController: UIViewController {
    private lazy var nextButton: UIButton = buttonStyle <<- [.text("Next"), .textColor(.black)]
    private lazy var mockForceUpdateButton: UIButton = buttonStyle <<- [.text("Force"), .textColor(.black), .color(.red)]
    private lazy var stackView: UIStackView = stackViewStyle <- .views([self.nextButton, self.mockForceUpdateButton, .spacer])
    
    private let viewModel: MockForceUpdateViewModel
    
    init(viewModel: MockForceUpdateViewModel) {
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

private extension MockForceUpdateViewController {
    
    func setupBindings() {
        
        nextButton.rx.tap
            .bind(to: viewModel.input.next)
            .disposed(by: disposeBag)
        
        mockForceUpdateButton.rx.tap
            .bind(to: viewModel.input.forceUpdate)
            .disposed(by: disposeBag)
    }
    
    func setupViews() {
        title = "FORCE UPDATE"
        view.backgroundColor = .white
        
        view.addSubview(stackView)
        stackView.edgesToSuperview()
    }
}
