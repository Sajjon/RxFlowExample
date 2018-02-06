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
        let setup: AnyObserver<Void>
    }
    struct Output {
        let setup: Observable<Void>
    }
    let input: Input
    let output: Output
    
    private let bag = DisposeBag()
    
    init() {
        let _setup = PublishSubject<Void>()
        input = Input(
            setup: _setup.asObserver()
        )
        output = Output(
            setup: _setup.asObservable()
        )
        output.setup.subscribe() { [unowned self] _ in self.step(to: .first(.permissionsDone)) }.disposed(by: bag)
    }
}
