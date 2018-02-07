//
//  AuthFlow.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-01.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import UIKit
import RxFlow

final class AuthFlow: Flow, Stepper {
    
    private let navigationViewController = UINavigationController()
    private let authService: AuthService
    
    init(service: AuthService) {
        self.authService = service
        self.step(to: .authStart)
    }
    
    
    deinit {
        print("❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️ AUTH flow DEINIT ❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️")
    }
}

extension AuthFlow {
    var root: UIViewController { return navigationViewController }
    
    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? AppStep else { return .stepNotHandled }
        switch step {
        case .auth(.start): return  navigate(to: AppStep.auth(.signInOrSignUp))
        case .auth(.signInOrSignUp): return navigateToSignInOrSignUpScreen()
        case .auth(.signIn): return navigateToSignInScreen()
        case .auth(.signUp): return navigateToSignUpScreen()
        case .auth(.signInDone), .auth(.signUpDone): self.step(to: .auth(.done)); return .none
        default: return .stepNotHandled
        }
    }
}

private extension AuthFlow {
    func navigateToSignInOrSignUpScreen() -> NextFlowItems {
        let viewModel = AuthViewModel()
        let viewController = AuthViewController(viewModel: viewModel)
        navigationViewController.viewControllers = [viewController]
        return .one(flowItem: NextFlowItem(nextPresentable: viewController, nextStepper: viewModel))
    }
    
    func navigateToSignUpScreen() -> NextFlowItems {
        let viewModel = SignUpViewModel(authService: authService)
        let viewController = SignUpViewController(viewModel: viewModel)
        navigationViewController.pushViewController(viewController, animated: true)
        return .one(flowItem: NextFlowItem(nextPresentable: viewController, nextStepper: viewModel))
    }
    
    func navigateToSignInScreen() -> NextFlowItems {
        let viewModel = SignInViewModel(authService: authService)
        let viewController = SignInViewController(viewModel: viewModel)
        navigationViewController.pushViewController(viewController, animated: true)
        return .one(flowItem: NextFlowItem(nextPresentable: viewController, nextStepper: viewModel))
    }
}
