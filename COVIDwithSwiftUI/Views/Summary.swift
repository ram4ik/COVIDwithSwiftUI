//
//  Summary.swift
//  COVIDwithSwiftUI
//
//  Created by Ramill Ibragimov on 28.10.2020.
//

import Foundation

struct Summary: Decodable {
    let Global: GlobalStats
    let Countries: [Country]
}
