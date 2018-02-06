//
//  BookingService.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-05.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import Foundation
import RxSwift

struct Booking {
    let name: String
}

final class BookingService {
    func getBookings() -> Observable<[Booking]> { return .just(["Hobo", "The Thief", "At Six"].map { Booking(name: $0) }) }
}
