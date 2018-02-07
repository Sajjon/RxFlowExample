//
//  VersionFlow.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-06.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import UIKit
import RxFlow

final class VersionFlow: Flow, Stepper {
    
    private let navigationViewController = UINavigationController()
    private let service: AppConfigService
    
    init(service: AppConfigService) {
        self.service = service
        step(to: .versionStart)
    }
    
    
    deinit {
        print("❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️ VERSION flow DEINIT ❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️")
    }
}

extension VersionFlow {
    var root: UIViewController { return navigationViewController }
    
    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? AppStep else { return .stepNotHandled }
        switch step {
        case .version(.start): return navigate(to: AppStep.version(.forceUpdate))
        case .version(.forceUpdate): return navigateToMockForceUpdateScreen()
        case .version(.forceUpdateBlock): return navigateToForceUpdateBlockingScreen()
        case .version(.onboarding): return navigateToOnboardingScreen()
        case .version(.onboardingDone): return navigateToNextFlow()
        default: return .stepNotHandled
        }
    }
}

private extension VersionFlow {
    func navigateToMockForceUpdateScreen() -> NextFlowItems {
        let viewModel = MockForceUpdateViewModel(service: service)
        let viewController = MockForceUpdateViewController(viewModel: viewModel)
        navigationViewController.viewControllers = [viewController]
        return .one(flowItem: NextFlowItem(nextPresentable: viewController, nextStepper: viewModel))
    }
    
    func navigateToForceUpdateBlockingScreen() -> NextFlowItems {
        let viewModel = MockForceUpdateViewModel(service: service)
        let viewController = ForceUpdateViewController(viewModel: viewModel)
        navigationViewController.viewControllers = [viewController]
        return .one(flowItem: NextFlowItem(nextPresentable: viewController, nextStepper: viewModel))
    }
    
    func navigateToOnboardingScreen() -> NextFlowItems {
        let viewModel = OnboardingViewModel()
        let viewController = OnboardingViewController(viewModel: viewModel)
        navigationViewController.viewControllers = [viewController]
        return .one(flowItem: NextFlowItem(nextPresentable: viewController, nextStepper: viewModel))
    }
    
    
    func navigateToNextFlow() -> NextFlowItems {
        step(to: .version(.done))
        return .none
    }
}

