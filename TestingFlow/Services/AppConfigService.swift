//
//  AppConfigService.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-06.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import Foundation
import RxSwift

struct AppConfig {
    let forceUpdate: Bool
}

final class AppConfigService {
    func getAppConfig() -> Observable<AppConfig> { return .just(AppConfig(forceUpdate: false)) }
}
