//
//  ProfileViewModel.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-05.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import Foundation
import RxSwift
import RxFlow

struct Account {
    let email: String
    let firstName: String
    let lastName: String
}

final class ProfileViewModel: Stepper {
    
    var email: Observable<String>
    let firstName: Observable<String>
    let lastName: Observable<String>
    lazy var name: Observable<String> = Observable.combineLatest(firstName, lastName) { "\($0) \($1)" }
    
    private let service: AuthService
    
    init(service: AuthService) {
        self.service = service
        let account = service.getAccount()
        email = account.map { $0.email }
        firstName = account.map { $0.firstName }
        lastName = account.map { $0.lastName }
    }
}
