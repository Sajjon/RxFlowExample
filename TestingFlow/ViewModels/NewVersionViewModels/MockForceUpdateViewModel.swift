//
//  MockForceUpdateViewModel.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-06.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import Foundation

import RxFlow
import RxSwift

final class MockForceUpdateViewModel: Stepper {
    struct Input {
        let next: AnyObserver<Void>
        let forceUpdate: AnyObserver<Void>
    }
    struct Output {
        let next: Observable<Void>
        let forceUpdate: Observable<Void>
    }
    let input: Input
    let output: Output
    
    private let service: AppConfigService
    private let bag = DisposeBag()
    
    init(service: AppConfigService) {
        self.service = service
        
        let _next = PublishSubject<Void>()
        let _forceUpdate = PublishSubject<Void>()

        input = Input(
            next: _next.asObserver(),
            forceUpdate: _forceUpdate.asObserver()
        )
        
        output = Output(
            next: _next.asObservable(),
            forceUpdate: _forceUpdate.asObservable()
        )
        output.next.subscribe() { [unowned self] _ in self.step(to: .version(.onboarding)) }.disposed(by: bag)
        output.forceUpdate.subscribe() { [unowned self] _ in self.step(to: .version(.forceUpdateBlock)) }.disposed(by: bag)
    }
}
