//
//  String.swift
//  Reciplease
//
//  Created by MacBook DS on 04/08/2019.
//  Copyright © 2019 Djilali Sakkar. All rights reserved.
//

import Foundation

extension String {
    func isEmptyOrWhitespace() -> Bool {
        if(self.isEmpty) {
            return true
        }
        return (self.trimmingCharacters(in: NSCharacterSet.whitespaces) == "")
    }
}

extension String {
    var convertStringTime: String {
        let hrs = Int(self)! / 60
        let min = Int(self)! % 60
        return hrs > 0 ? String(format: "%1dh%02d min", hrs, min) : String(format: "%1d min", min)
    }
}

