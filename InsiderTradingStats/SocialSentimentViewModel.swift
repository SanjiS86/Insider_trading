//
//  SocialSentimentViewModel.swift
//  InsiderTradingStats
//
//  Created by Sanzhi Kobzhan on 19.09.2024.
//
import Foundation

class SocialSentimentViewModel: ObservableObject {
    @Published var sentimentData: [SocialSentimentData] = []
    
    func fetchSentimentData(for ticker: String) {
        let apiKey = ""
        guard let url = URL(string: "https://financialmodelingprep.com/api/v4/historical/social-sentiment?symbol=\(ticker)&page=0&apikey=\(apiKey)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let decodedData = try JSONDecoder().decode([SocialSentimentData].self, from: data)
                DispatchQueue.main.async {
                    self.sentimentData = decodedData.sorted { $0.date > $1.date }
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }.resume()
    }
}
