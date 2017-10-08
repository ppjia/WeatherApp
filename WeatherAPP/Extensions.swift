//
//  Extensions.swift
//  WeatherAPP
//
//  Created by ruixue on 8/10/17.
//  Copyright © 2017 rui. All rights reserved.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Generator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
