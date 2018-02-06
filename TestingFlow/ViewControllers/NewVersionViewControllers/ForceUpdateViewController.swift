//
//  ForceUpdateViewController.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-06.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import UIKit
import ViewComposer
import TinyConstraints

final class ForceUpdateViewController: UIViewController {
    private lazy var forceUpdateLabel: UILabel = [.font(UIFont.systemFont(ofSize: 40)), .text("UPDATE THE APP!!"), .textAlignment(.center), .numberOfLines(0)]
    private lazy var dismissButton: UIButton = buttonStyle <<- [.text("Dismiss (debug only)"), .color(.red)]
    private lazy var stackView: UIStackView = stackViewStyle <- .views([self.forceUpdateLabel, self.dismissButton, .spacer])
    
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

private extension ForceUpdateViewController {
    
    func setupBindings() {
        
        dismissButton.rx.tap
            .bind(to: viewModel.input.next)
            .disposed(by: disposeBag)
    }
    
    func setupViews() {
        title = "FORCE UPDATE"
        view.backgroundColor = .white
        
        view.addSubview(stackView)
        stackView.edgesToSuperview()
    }
}
