//
//  Country.swift
//  COVIDwithSwiftUI
//
//  Created by Ramill Ibragimov on 28.10.2020.
//

import Foundation

struct Country: Decodable {
    let name: String
    let slug: String
    let totalConfirmed: Int
    let totalRecovered: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "Country"
        case slug = "Slug"
        case totalConfirmed = "TotalConfirmed"
        case totalRecovered = "TotalRecovered"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        slug = try container.decode(String.self, forKey: .slug)
        totalConfirmed = try container.decode(Int.self, forKey: .totalConfirmed)
        totalRecovered = try container.decode(Int.self, forKey: .totalRecovered)
    }
}
