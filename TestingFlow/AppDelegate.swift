//
//  AppDelegate.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-01.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import UIKit
import RxSwift
import RxFlow

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, HasDisposeBag {
    var window: UIWindow?
    
    private let coordinator = Coordinator()
    let authService = AuthService()
    lazy var appFlow: AppFlow = AppFlow(withService: authService)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window
        coordinator.rx.didNavigate.subscribe(onNext: { (flow, step) in print("did navigate to flow=\(flow) and step=\(step)") }).disposed(by: disposeBag)
        Flows.whenReady(flow1: appFlow) { [unowned window] in window.rootViewController = $0 }
        coordinator.coordinate(flow: appFlow, withStepper: OneStepper(withSingleStep: AppStep.initial))
        return true
    }
}


