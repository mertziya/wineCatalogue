//
//  Wine.swift
//  WineCatalogue
//
//  Created by Mert Ziya on 3.12.2024.
//

import Foundation

// MARK: - Wine
struct Wine: Codable, Identifiable {
    let winery, wine: String
    let rating: Rating
    let location: String
    let image: String
    let id: Int
}

// MARK: - Rating
struct Rating: Codable {
    let average, reviews: String
}
