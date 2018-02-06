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
    
    init(navigationViewController: UINavigationController, service: AuthService) {
        self.navigationViewController = navigationViewController
        self.authService = service
        step(to: .firstStart)
    }
    
    deinit {
        print("❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️ FirstRun flow DEINIT ❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️")
    }
}

extension FirstRunFlow {
    var root: UIViewController { return navigationViewController }
    
    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? AppStep else { return .stepNotHandled }
        switch step {
        case .first(.start): return navigate(to: AppStep.first(.applePay))
        case .first(.applePay): return navigateToApplePaySplashScreen()
        case .first(.applePayDone): return navigate(to: AppStep.first(.permissions))
        case .first(.permissions): return navigateToPermissionsScreen()
        case .first(.permissionsDone): return navigateToNextFlow()
        default: return .stepNotHandled
        }
    }
}

private extension FirstRunFlow {
    
    
    func navigateToApplePaySplashScreen() -> NextFlowItems {
        let viewModel = ApplePaySpashViewModel()
        let viewController = ApplePaySplashViewController(viewModel: viewModel)
        
        //        navigationViewController.viewControllers = [viewController]
        navigationViewController.pushViewController(viewController, animated: true)
        
        return .one(flowItem: NextFlowItem(nextPresentable: viewController, nextStepper: viewModel))
    }
    
    func navigateToPermissionsScreen() -> NextFlowItems {
        let viewModel = PermissionsViewModel()
        let viewController = PermissionsViewController(viewModel: viewModel)
        
//        navigationViewController.viewControllers = [viewController]
        navigationViewController.pushViewController(viewController, animated: true)
        
        return .one(flowItem: NextFlowItem(nextPresentable: viewController, nextStepper: viewModel))
    }
    
    func navigateToNextFlow() -> NextFlowItems {
        step(to: .first(.done))
        return .none
    }
}

