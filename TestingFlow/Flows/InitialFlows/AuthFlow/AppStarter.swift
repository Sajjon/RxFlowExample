//
//  AppStarter.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-01.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import Foundation
import RxFlow

protocol AppStarter: Flow {
    var authService: AuthService { get }
    var navigationViewController: UINavigationController { get }
    func navigateToMainScreen() -> NextFlowItems
}

extension AppStarter {
    func navigateToMainScreen() -> NextFlowItems {
        print("*** STARTING APP ***")
        
        let tabbarController = UITabBarController()
        let myStaysFlow = MyStaysFlow(bookingService: BookingService())
        let profileFlow = ProfileFlow(authService: authService)
        Flows.whenReady(flow1: myStaysFlow, flow2: profileFlow, block: { [unowned self] (tab1Root: UINavigationController, tab2Root: UINavigationController) in
            let tabBarItem1 = UITabBarItem(title: "My stays", image: UIImage(named: "wishlist"), selectedImage: nil)
            let tabBarItem2 = UITabBarItem(title: "Profile", image: UIImage(named: "watched"), selectedImage: nil)
            tab1Root.tabBarItem = tabBarItem1
            tab2Root.tabBarItem = tabBarItem2
          
            tabbarController.setViewControllers([tab1Root, tab2Root], animated: false)
            self.navigationViewController.viewControllers = [tabbarController]
        })
        
        return .multiple(flowItems: [
            NextFlowItem(nextPresentable: myStaysFlow, nextStepper: myStaysFlow),
            NextFlowItem(nextPresentable: profileFlow, nextStepper: profileFlow)
        ])
    }
}


extension NextFlowItem {
    init<N>(_ next: N) where N: Presentable & Stepper {
        self.init(nextPresentable: next, nextStepper: next)
    }
}

