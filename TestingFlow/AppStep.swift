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
    case initial, signInOrSignUp, signIn, signUp
    case main, myStays, book, profile, more
}
