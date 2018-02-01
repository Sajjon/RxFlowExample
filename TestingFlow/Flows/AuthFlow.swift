//
//  AuthFlow.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-01.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import UIKit
import RxFlow

final class AuthFlow: AppStarter, Stepper {
    
    private let navigationViewController: UINavigationController
    private let authService: AuthService
    
    init(navigationViewController: UINavigationController, withService service: AuthService) {
        self.navigationViewController = navigationViewController
        self.authService = service
        self.step.accept(AppStep.signInOrSignUp)
    }
}

extension AuthFlow {
    var root: UIViewController { return navigationViewController }
    
    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? AppStep else { return .stepNotHandled }
        switch step {
        case .signInOrSignUp: return navigateToSignInOrSignUpScreen()
        case .signIn: return navigateToSignInScreen()
        case .signUp: return navigateToSignUpScreen()
        case .main: return navigateToMainScreen()
        default: return .stepNotHandled
        }
    }
}

private extension AuthFlow {
    func navigateToSignInOrSignUpScreen() -> NextFlowItems {
        let viewModel = AuthViewModel()
        let viewController = AuthViewController(viewModel: viewModel)
        self.navigationViewController.pushViewController(viewController, animated: true)
        return .one(flowItem: NextFlowItem(nextPresentable: viewController, nextStepper: viewModel))
    }
    
    func navigateToSignUpScreen() -> NextFlowItems {
        let viewModel = SignUpViewModel(authService: authService)
        let viewController = SignUpViewController(viewModel: viewModel)
        self.navigationViewController.pushViewController(viewController, animated: true)
        return .one(flowItem: NextFlowItem(nextPresentable: viewController, nextStepper: viewModel))
    }
    
    func navigateToSignInScreen() -> NextFlowItems {
        let viewModel = SignInViewModel(authService: authService)
        let viewController = SignInViewController(viewModel: viewModel)
        self.navigationViewController.pushViewController(viewController, animated: true)
        return .one(flowItem: NextFlowItem(nextPresentable: viewController, nextStepper: viewModel))
    }
}
