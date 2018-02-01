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
    func signUp(email: String, password: String) -> Observable<Void> { print("signing up, @:`\(email)`, #:`\(password)`"); return Observable.just(()) }
    func signIn(email: String, password: String) -> Observable<Void> { print("signing in, @:`\(email)`, #:`\(password)`"); return Observable.just(()) }
}
