//
//  AppFlow.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-01.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import UIKit
import RxFlow

final class AppFlow: AppStarter {
    let navigationViewController = UINavigationController()
    let authService: AuthService
    init(withService service: AuthService) {
        self.authService = service
    }
}

extension AppFlow {
    var root: UIViewController { return navigationViewController }
    
    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? AppStep else { return .stepNotHandled }
        switch step {
        case .start: return navigate(to: initialStep)
        case .first: return navigateToFirstRunScreen()
        case .auth: return navigateToSignInOrSignUpScreen()
        case .main: return navigateToMainScreen()
        default: return .stepNotHandled
        }
    }
}

private extension AppFlow {
    var initialStep: Step {
        guard !isFirstRun else { return AppStep.firstStart }
        let step: AppStep = isLoggedIn ? .mainStart : .authStart
        return step
    }
    var isLoggedIn: Bool { return false }
    var isFirstRun: Bool { return true }
    
    func navigateToFirstRunScreen() -> NextFlowItems {
        let firstRunFlow = FirstRunFlow(navigationViewController: navigationViewController, withService: authService)
        return .one(flowItem: NextFlowItem(firstRunFlow))
    }
    
    func navigateToSignInOrSignUpScreen() -> NextFlowItems {
        let authFlow = AuthFlow(navigationViewController: navigationViewController, withService: authService)
        return .one(flowItem: NextFlowItem(authFlow))
    }
    
    
}
