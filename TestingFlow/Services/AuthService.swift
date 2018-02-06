//
//  AuthService.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-01.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import Foundation
import RxSwift

final class AuthService {
    private var email: String = "alex.cyon@gmail.com"
    private var account: Account { return Account(email: email, firstName: "Alex", lastName: "Cyon") }
    func getAccount() -> Observable<Account> { return Observable.just(account) }
    func signUp(email: String, password: String) -> Observable<Void> { print("signing up, @:`\(email)`, #:`\(password)`"); self.email = email; return .just(()) }
    func signIn(email: String, password: String) -> Observable<Void> { print("signing in, @:`\(email)`, #:`\(password)`"); self.email = email; return .just(()) }
}
