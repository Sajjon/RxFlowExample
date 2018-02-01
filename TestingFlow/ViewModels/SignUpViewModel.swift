//
//  SignUpViewModel.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-01.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import Foundation
import RxFlow
import RxSwift

final class SignUpViewModel: Stepper {
    struct Input {
        let signUp: AnyObserver<Void>
        let email: AnyObserver<String>
        let password: AnyObserver<String>
    }
    struct Output {
        let signUp: Observable<Void>
    }
    let input: Input
    let output: Output
    
    private let authService: AuthService
    private let bag = DisposeBag()
    
    init(authService: AuthService) {
        self.authService = authService
        
        let _signUp = PublishSubject<Void>()
        let _email = PublishSubject<String>()
        let _password = PublishSubject<String>()
        input = Input(
            signUp: _signUp.asObserver(),
            email: _email.asObserver(),
            password: _password.asObserver()
        )
        output = Output(
            signUp: Observable.combineLatest(_email, _password, _signUp) { email, password, _ in (email, password) }
                .flatMapLatest {
                    authService.signUp(email: $0, password: $1)
            }
        )
        output.signUp.subscribe() { [unowned self] _ in self.step.accept(AppStep.main) }.disposed(by: bag)
    }
}
