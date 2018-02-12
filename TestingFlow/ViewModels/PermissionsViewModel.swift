//
//  PermissionsViewModel.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-06.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import Foundation
import RxSwift
import RxFlow


final class PermissionsViewModel: Stepper {
    struct Input {
        let allow: AnyObserver<Void>
    }
    struct Output {
        let allow: Observable<Void>
    }
    let input: Input
    let output: Output
    
    private let bag = DisposeBag()
    
    init() {
        let _allow = PublishSubject<Void>()
        input = Input(
            allow: _allow.asObserver()
        )
        output = Output(
            allow: _allow.asObservable()
        )
        output.allow.subscribe() { [unowned self] _ in self.step(to: .first(.permissionsDone)) }.disposed(by: bag)
    }
}
