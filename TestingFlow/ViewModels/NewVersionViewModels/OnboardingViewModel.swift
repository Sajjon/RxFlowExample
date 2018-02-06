//
//  OnboardingViewModel.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-06.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import Foundation

import RxFlow
import RxSwift

final class OnboardingViewModel: Stepper {
    struct Input {
        let done: AnyObserver<Void>
    }
    struct Output {
        let done: Observable<Void>
    }
    let input: Input
    let output: Output
    
    private let bag = DisposeBag()
    
    init() {
        let _done = PublishSubject<Void>()
        
        input = Input(
            done: _done.asObserver()
        )
        
        output = Output(
            done: _done.asObservable()
        )
        output.done.subscribe() { [unowned self] _ in self.step(to: .version(.onboardingDone)) }.disposed(by: bag)
    }
}
