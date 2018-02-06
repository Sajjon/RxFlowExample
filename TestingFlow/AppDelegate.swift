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
import Swinject
import SwinjectAutoregistration

@UIApplicationMain
class AppDelegate: UIResponder {
    var window: UIWindow?
    
    private let coordinator = Coordinator()
    private let container = makeContainer()
    private lazy var appFlow: AppFlow = AppFlow(container: container)
}

extension AppDelegate: UIApplicationDelegate, HasDisposeBag {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window
        coordinator.rx.didNavigate.subscribe(onNext: { (flow, step) in print("Did navigate to flow=\(flow) and step=\(step)") }).disposed(by: disposeBag)
        Flows.whenReady(flow1: appFlow) { [unowned window] in window.rootViewController = $0 }
        coordinator.coordinate(flow: appFlow, withStepper: appFlow)
        return true
    }
}

private func makeContainer() -> Container {
    return Container()
}
