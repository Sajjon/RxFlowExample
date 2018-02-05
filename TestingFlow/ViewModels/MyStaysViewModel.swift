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
    
    let bookings: Observable<[Booking]>
    
    init(service: BookingService) {
        bookings = service.getBookings()
    }
}
