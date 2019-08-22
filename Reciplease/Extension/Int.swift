//
//  Time.swift
//  Reciplease
//
//  Created by MacBook DS on 04/08/2019.
//  Copyright © 2019 Djilali Sakkar. All rights reserved.
//

import Foundation

/// Method that converts time from Int to String
extension Int {
    var convertTime: String {
        let hrs = self / 60
        let min = self % 60
        return hrs > 0 ? String(format: "%1dh%02d min", hrs, min) : String(format: "%1d min", min)
    }
}
