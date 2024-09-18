//
//  InsiderData.swift
//  InsiderTradingStats
//
//  Created by Sanzhi Kobzhan on 18.09.2024.
//
import Foundation

struct InsiderData: Codable, Identifiable, Equatable {
    let id = UUID()
    let symbol: String
    let cik: String
    let year: Int
    let quarter: Int
    let totalBought: Double
    let totalSold: Double
    
    enum CodingKeys: String, CodingKey {
        case symbol, cik, year, quarter, totalBought, totalSold
    }

    static func ==(lhs: InsiderData, rhs: InsiderData) -> Bool {
        return lhs.year == rhs.year && lhs.quarter == rhs.quarter && lhs.symbol == rhs.symbol
    }
}
