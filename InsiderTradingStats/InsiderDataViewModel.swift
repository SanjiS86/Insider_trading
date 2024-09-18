//
//  InsiderDataViewModel.swift
//  InsiderTradingStats
//
//  Created by Sanzhi Kobzhan on 18.09.2024.


import Foundation

class InsiderDataViewModel: ObservableObject {
    @Published var insiderData: [InsiderData] = []
    
    func fetchData(for ticker: String) {
        let apiKey = ""
        guard let url = URL(string: "https://financialmodelingprep.com/api/v4/insider-roaster-statistic?symbol=\(ticker)&apikey=\(apiKey)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let decodedData = try JSONDecoder().decode([InsiderData].self, from: data)
                DispatchQueue.main.async {
                    self.insiderData = decodedData.sorted { $0.year == $1.year ? $0.quarter > $1.quarter : $0.year > $1.year }
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }.resume()
    }
}
