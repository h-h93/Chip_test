//
//  DogsModel.swift
//  Chip_test
//
//  Created by hanif hussain on 21/02/2024.
//

import Foundation
import UIKit

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

// holding our dogs in a custom struct so we can assign image and imageurl
struct DogsModel {
    var breed: String
    var imageURL: URL
    var image: UIImage?
}
