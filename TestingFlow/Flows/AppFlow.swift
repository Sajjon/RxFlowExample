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
    private let navigationViewController = UINavigationController()
    private let authService: AuthService
    init(withService service: AuthService) {
        self.authService = service
    }
}

extension AppFlow {
    var root: UIViewController { return navigationViewController }
    
    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? AppStep else { return .stepNotHandled }
        switch step {
        case .initial: return navigate(to: initialStep)
        case .signInOrSignUp: return navigateToSignInOrSignUpScreen()
        case .main: return navigateToMainScreen()
        default: return .stepNotHandled
        }
    }
}

private extension AppFlow {
    var initialStep: Step { let step: AppStep = isLoggedIn ? .main : .signInOrSignUp; return step }
    var isLoggedIn: Bool { return false }
    
    func navigateToSignInOrSignUpScreen() -> NextFlowItems {
        let authFlow = AuthFlow(navigationViewController: navigationViewController, withService: authService)
        return .one(flowItem: NextFlowItem(authFlow))
    }
    
    
}
