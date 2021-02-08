//
//  PryanikiData.swift
//  Example
//
//  Created by Viktor Golubenkov on 08.02.2021.
//

import Foundation

// MARK: - PryanikiData
struct PryanikiData: Codable {
    let data: [Pryaniki]
    let view: [String]
}

// MARK: - Pryaniki
struct Pryaniki: Codable {
    let name: String
    let data: DataClass
    
}

// MARK: - DataClass
struct DataClass: Codable {
    let text: String?
    let url: String?
    let selectedID: Int?
    let variants: [Variant]?

    enum CodingKeys: String, CodingKey {
        case text, url
        case selectedID = "selectedId"
        case variants
    }
}

// MARK: - Variant
struct Variant: Codable {
    let id: Int
    let text: String
}
