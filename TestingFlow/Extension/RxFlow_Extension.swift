//
//  RxFlow_Extension.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-05.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa

extension BehaviorRelay where Element == Step {
    func accept(_ step: AppStep) {
        accept(step as Step)
    }
}

extension Stepper {
    func step(to nextStep: AppStep) {
        self.step.accept(nextStep)
    }
}
