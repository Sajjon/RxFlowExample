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

final class MyPageFlow: Flow, Stepper {
    
    private let navigationViewController = UINavigationController()
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
        step(to: .main(.tab(.myPage)))
    }
}

extension MyPageFlow {
    var root: UIViewController { return navigationViewController }
    
    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? AppStep, case let .main(main) = step else { return .stepNotHandled }
        switch main {
        case .tab(.myStays): print("~~~ My Stays not handled ~~~"); return .stepNotHandled
        case .tab(.myPage): return navigateToMyPageScreen()
        default: return .stepNotHandled
        }
    }
}

private extension MyPageFlow {
    func navigateToMyPageScreen() -> NextFlowItems {
        let viewModel = ProfileViewModel(service: authService)
        let viewController = ProfileViewController(viewModel: viewModel)
        self.navigationViewController.pushViewController(viewController, animated: true)
        return .one(flowItem: NextFlowItem(nextPresentable: viewController, nextStepper: viewModel))
    }
}
