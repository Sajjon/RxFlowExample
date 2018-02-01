//
//  AuthViewModel.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-01.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import Foundation
import RxFlow
import RxSwift

final class AuthViewModel: Stepper {
    struct Input {
        let signUp: AnyObserver<Void>
        let signIn: AnyObserver<Void>
    }
    struct Output {
        let signUp: Observable<Void>
        let signIn: Observable<Void>
    }
    let input: Input
    let output: Output
    private let bag = DisposeBag()
    init() {
        let _signUp = PublishSubject<Void>()
        let _signIn = PublishSubject<Void>()
        input = Input(
            signUp: _signUp.asObserver(),
            signIn: _signIn.asObserver()
        )
        output = Output(
            signUp: _signUp.asObservable(),
            signIn: _signIn.asObservable()
        )
        output.signUp.subscribe() { [unowned self] _ in self.step.accept(AppStep.signUp) }.disposed(by: bag)
        output.signIn.subscribe() { [unowned self] _ in self.step.accept(AppStep.signIn) }.disposed(by: bag)
    }
}
