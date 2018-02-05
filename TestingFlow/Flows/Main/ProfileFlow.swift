//
//  ProfileFlow.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-05.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import Foundation
import UIKit
import RxFlow

final class ProfileFlow: Flow, Stepper {
    
    private let navigationViewController = UINavigationController()
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
        step(to: .profile)
    }
}

extension ProfileFlow {
    var root: UIViewController { return navigationViewController }
    
    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? AppStep else { return .stepNotHandled }
        switch step {
        case .profile: return navigateToMyProfileScreen()
        default: return .stepNotHandled
        }
    }
}

private extension ProfileFlow {
    func navigateToMyProfileScreen() -> NextFlowItems {
        let viewModel = ProfileViewModel(service: authService)
        let viewController = ProfileViewController(viewModel: viewModel)
        self.navigationViewController.pushViewController(viewController, animated: true)
        return .one(flowItem: NextFlowItem(nextPresentable: viewController, nextStepper: viewModel))
    }
}
