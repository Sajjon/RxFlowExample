//
//  MyStaysViewModel.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-05.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import Foundation
import RxFlow
import RxSwift

final class MyStaysViewModel: Stepper {
    
    struct Input {
        let reload: AnyObserver<Void>
    }
    struct Output {
        let bookings: Observable<[Booking]>
    }

    let input: Input
    let output: Output
    
    init(service: BookingService) {
        
        let _reload = PublishSubject<Void>()
        input = Input(
            reload: _reload.asObserver()
        )
        
        output = Output(
            bookings: _reload.asObservable().flatMapLatest { service.getBookings() }
        )
    }
}
