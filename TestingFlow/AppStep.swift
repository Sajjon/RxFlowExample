//
//  AppStep.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-01.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import Foundation
import RxFlow

enum AppStep: Step {
    
    case start // Never Ending Story
    
    indirect case first(First)
    static var firstStart: AppStep { return .first(.start) }
    enum First: Step {
        case start, done
        case applePay, applePayDone
        case permissions, permissionsDone
    }
    
    indirect case version(Version)
    static var versionStart: AppStep { return .version(.start) }
    enum Version: Step {
        case start, done
        case forceUpdate, forceUpdateBlock
        case onboarding, onboardingDone
    }
    
    indirect case auth(Auth)
    static var authStart: AppStep { return .auth(.start) }
    enum Auth: Step {
        case start, done
        case signInOrSignUp
        case signIn, signInDone
        case signUp, signUpDone
    }

    indirect case main(Main)
    static var mainStart: AppStep { return .main(.start) }
    enum Main: Step {
        case start // Never Ending Story
        indirect case tab(Tab)
        enum Tab: Step {
            case myStays, book, myPage, more
        }
    }
}
