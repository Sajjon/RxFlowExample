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
    
    let navigationViewController: UINavigationController
    let service: AppConfigService
    
    init(navigationViewController: UINavigationController, service: AppConfigService) {
        self.navigationViewController = navigationViewController
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
        
        Flows.whenReady(flow1: self, block: { [unowned self] _ in
            self.navigationViewController.viewControllers = [viewController]
        })
        
        return .one(flowItem: NextFlowItem(nextPresentable: viewController, nextStepper: viewModel))
    }
    
    func navigateToForceUpdateBlockingScreen() -> NextFlowItems {
        let viewModel = MockForceUpdateViewModel(service: service)
        let viewController = ForceUpdateViewController(viewModel: viewModel)
        
        Flows.whenReady(flow1: self, block: { [unowned self] _ in
            self.navigationViewController.viewControllers = [viewController]
        })
        
        return .one(flowItem: NextFlowItem(nextPresentable: viewController, nextStepper: viewModel))
    }
    
    func navigateToOnboardingScreen() -> NextFlowItems {
        let viewModel = OnboardingViewModel()
        let viewController = OnboardingViewController(viewModel: viewModel)

        Flows.whenReady(flow1: self, block: { [unowned self] _ in
            self.navigationViewController.viewControllers = [viewController]
        })

        return .one(flowItem: NextFlowItem(nextPresentable: viewController, nextStepper: viewModel))
    }
    
    
    func navigateToNextFlow() -> NextFlowItems {
        step(to: .version(.done))
        navigationViewController.presentedViewController?.dismiss(animated: true)
//        navigationViewController.dismiss(animated: true, completion: nil)
        return .none
    }
}

