//
//  FirstRunFlow.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-05.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import UIKit
import RxFlow

final class FirstRunFlow: Flow, Stepper {
    
    let navigationViewController: UINavigationController
    let authService: AuthService
    
    init(navigationViewController: UINavigationController, withService service: AuthService) {
        self.navigationViewController = navigationViewController
        self.authService = service
        step(to: .firstStart)
    }
}

extension FirstRunFlow {
    var root: UIViewController { return navigationViewController }
    
    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? AppStep, case let .first(first) = step else { return .stepNotHandled }
        switch first {
        case .start: return navigateToFirstRunScreen()
        default: return .stepNotHandled
        }
    }
}

private extension FirstRunFlow {
    func navigateToFirstRunScreen() -> NextFlowItems {
        print("FIRST RUN!!")
        return .stepNotHandled
//        let viewModel = AuthViewModel()
//        let viewController = AuthViewController(viewModel: viewModel)
//        self.navigationViewController.pushViewController(viewController, animated: true)
//        return .one(flowItem: NextFlowItem(nextPresentable: viewController, nextStepper: viewModel))
    }
}
