//
//  OnboardingViewController.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-06.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import UIKit
import ViewComposer
import TinyConstraints
import RxSwift
import RxCocoa

final class OnboardingViewController: UIViewController {
    private lazy var doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let viewModel: OnboardingViewModel
    
    init(viewModel: OnboardingViewModel) {
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

private extension OnboardingViewController {
    
    func setupBindings() {
        doneButton.rx.tap
            .bind(to: viewModel.input.done)
            .disposed(by: disposeBag)
    }
    
    func setupViews() {
        title = "Whats new?"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = doneButton
        
        view.addSubview(collectionView)
        collectionView.edgesToSuperview()
    }
}
