//
//  AppFlow.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-01.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import UIKit
import RxFlow
import Swinject
import SwinjectAutoregistration

final class AppFlow: Flow, Stepper {
    let navigationViewController = UINavigationController()
    
    private let container: Container
    private lazy var authService = container ~> AuthService.self
    private lazy var appConfigService = container ~> AppConfigService.self
    
    init(container parent: Container) {
        navigationViewController.view.backgroundColor = .green
        container = makeContainer(parent: parent)
        step(to: .start)
    }
    
    deinit {
        print("❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️ APPFLOW DEINIT ❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️")
    }
}

private func makeContainer(parent: Container) -> Container {
    return Container(parent: parent) { c in
        c.autoregister(AuthService.self, initializer: AuthService.init).inObjectScope(.container)
        c.autoregister(AppConfigService.self, initializer: AppConfigService.init).inObjectScope(.container)
    }
}

extension AppFlow {
    var root: UIViewController { return navigationViewController }
    
    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? AppStep else { return .stepNotHandled }
        switch step {
        case .start: return navigate(to: initialStep)
            
        case .first(.start): return startFirstRunFlow()
        case .first(.done):
            navigationViewController.presentedViewController?.dismiss(animated: false)
            return navigate(to: AppStep.versionStart)
            
        case .version(.start): return startVersionFlow()
        case .version(.done):
            navigationViewController.presentedViewController?.dismiss(animated: false)
            return navigate(to: AppStep.authStart)
            
        case .auth(.start): return startAuthFlow()
        case .auth(.done):
            navigationViewController.presentedViewController?.dismiss(animated: false)
            return navigate(to: AppStep.mainStart)
            
        case .main(.start): return startMainFlow()
        default: return .stepNotHandled
        }
    }
}

extension NextFlowItem {
    init<N>(_ next: N) where N: Presentable & Stepper {
        self.init(nextPresentable: next, nextStepper: next)
    }
}

private extension AppFlow {
    var initialStep: Step {
        guard !isFirstRun else { return AppStep.firstStart }
        let step: AppStep = isLoggedIn ? .mainStart : .authStart
        return step
    }
    var isLoggedIn: Bool { return false }
    var isFirstRun: Bool { return true }
    
    func startFirstRunFlow() -> NextFlowItems {
        print("💜💜💜💜💜 Start First Flow")
        let firstRunFlow = FirstRunFlow(service: authService)
        Flows.whenReady(flow1: firstRunFlow) { [weak self] in self?.navigationViewController.present($0, animated: false, completion: nil) }
        return .one(flowItem: NextFlowItem(firstRunFlow))
    }
    
    func startVersionFlow() -> NextFlowItems {
        print("💚💚💚💚💚💚 Start Version Flow")
        let flow = VersionFlow(service: appConfigService)
        Flows.whenReady(flow1: flow) { [weak self] in self?.navigationViewController.present($0, animated: false, completion: nil) }
        return .one(flowItem: NextFlowItem(flow))
    }
    
    func startAuthFlow() -> NextFlowItems {
        print("💙💙💙💙💙💙 Start Auth Flow")
        let flow = AuthFlow(service: authService)
        Flows.whenReady(flow1: flow) { [weak self] in self?.navigationViewController.present($0, animated: false, completion: nil) }
        return .one(flowItem: NextFlowItem(flow))
    }
    
    func startMainFlow() -> NextFlowItems {
        print("💛💛💛💛💛 STARTING APP 💛")
        
        let tabbarController = UITabBarController()
        let myStaysFlow = MyStaysFlow(bookingService: BookingService())
        let myPageFlow = MyPageFlow(authService: authService)
        Flows.whenReady(flow1: myStaysFlow, flow2: myPageFlow, block: { [unowned self] (tab1Root: UINavigationController, tab2Root: UINavigationController) in
            let tabBarItem1 = UITabBarItem(title: "My stays", image: nil, selectedImage: nil)
            let tabBarItem2 = UITabBarItem(title: "Profile", image: nil, selectedImage: nil)
            tab1Root.tabBarItem = tabBarItem1
            tab2Root.tabBarItem = tabBarItem2
            
            tabbarController.setViewControllers([tab1Root, tab2Root], animated: false)
            self.navigationViewController.viewControllers = [tabbarController]
        })
        
        return .multiple(flowItems: [
            NextFlowItem(nextPresentable: myStaysFlow, nextStepper: myStaysFlow),
            NextFlowItem(nextPresentable: myPageFlow, nextStepper: myPageFlow)
            ])
    }
}
