//
//  SocialSentimentData.swift
//  InsiderTradingStats
//
//  Created by Sanzhi Kobzhan on 19.09.2024.
//
import Foundation

struct SocialSentimentData: Codable, Identifiable, Equatable {
    let id = UUID()
    let date: String
    let twitterSentiment: Double
    
    enum CodingKeys: String, CodingKey {
        case date
        case twitterSentiment
    }
}

