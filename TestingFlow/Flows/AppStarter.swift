//
//  AppStarter.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-01.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import Foundation
import RxFlow

protocol AppStarter: Flow {
    func navigateToMainScreen() -> NextFlowItems
}

extension AppStarter {
    func navigateToMainScreen() -> NextFlowItems {
        print("*** STARTING APP ***")
        return .stepNotHandled
    }
}


extension NextFlowItem {
    init<N>(_ next: N) where N: Presentable & Stepper {
        self.init(nextPresentable: next, nextStepper: next)
    }
}
