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
        self.step(to: .main(.tab(.myStays)))
    }
}

extension MyStaysFlow {
    var root: UIViewController { return navigationViewController }
    
    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? AppStep, case let .main(main) = step else { return .stepNotHandled }
        switch main {
        case .tab(.myStays): return navigateToMyStaysScreen()
        case .tab(.myPage): print("~~~ My Page not handled ~~~"); return .stepNotHandled
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
