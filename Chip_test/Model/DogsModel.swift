//
//  DogsModel.swift
//  Chip_test
//
//  Created by hanif hussain on 21/02/2024.
//

import Foundation

// MARK: - Dogs
struct Dogs: Codable {
    let message: [String: [String]]
    let status: String
}

// MARK: - DogImages
struct DogImages: Codable {
    let message: [String]?
    let status: String?
}
