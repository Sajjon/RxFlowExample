//
//  MyStaysFlow.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-05.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import Foundation
import UIKit
import RxFlow

final class MyStaysFlow: Flow, Stepper {
    
    private let navigationViewController = UINavigationController()
    private let bookingService: BookingService
    
    init(bookingService: BookingService) {
        self.bookingService = bookingService
        self.step.accept(AppStep.myStays)
    }
}

extension MyStaysFlow {
    var root: UIViewController { return navigationViewController }
    
    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? AppStep else { return .stepNotHandled }
        switch step {
        case .myStays: return navigateToMyStaysScreen()
        default: return .stepNotHandled
        }
    }
}

private extension MyStaysFlow {
    func navigateToMyStaysScreen() -> NextFlowItems {
        let viewModel = MyStaysViewModel(service: bookingService)
        let viewController = MyStaysViewController(viewModel: viewModel)
        self.navigationViewController.pushViewController(viewController, animated: true)
        return .one(flowItem: NextFlowItem(nextPresentable: viewController, nextStepper: viewModel))
    }
}
