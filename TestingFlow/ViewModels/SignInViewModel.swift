//
//  SignInViewModel.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-01.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import RxSwift
import RxFlow

final class SignInViewModel: Stepper {
    struct Input {
        let signIn: AnyObserver<Void>
        let email: AnyObserver<String>
        let password: AnyObserver<String>
    }
    struct Output {
        let signIn: Observable<Void>
    }
    let input: Input
    let output: Output
    
    private let authService: AuthService
    private let bag = DisposeBag()
    
    init(authService: AuthService) {
        self.authService = authService
        
        let _signIn = PublishSubject<Void>()
        let _email = PublishSubject<String>()
        let _password = PublishSubject<String>()
        input = Input(
            signIn: _signIn.asObserver(),
            email: _email.asObserver(),
            password: _password.asObserver()
        )
        output = Output(
            signIn: Observable.combineLatest(_email, _password, _signIn) { email, password, _ in (email, password) }
                .flatMapLatest {
                    authService.signIn(email: $0, password: $1)
            }
        )
        output.signIn.subscribe() { [unowned self] _ in self.step.accept(AppStep.main) }.disposed(by: bag)
    }
}

