//
//  ContentView.swift
//  InsiderTradingStats
//
//  Created by Sanzhi Kobzhan on 18.09.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = InsiderDataViewModel()
    @State private var selectedPeriod: InsiderData?
    @State private var ticker: String = "AAPL"

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter Ticker", text: $ticker)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button(action: {
                        viewModel.fetchData(for: ticker.uppercased())
                    }) {
                        Text("Fetch Data")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }

                if let latestData = viewModel.insiderData.first {
                    Text("Latest Data: Year \(latestData.year), Quarter \(latestData.quarter)")
                        .font(.headline)
                        .padding()

                 
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(viewModel.insiderData) { data in
                                Button(action: {
                                    selectedPeriod = data
                                }) {
                                    VStack {
                                        Text("Year \(data.year), Q\(data.quarter)")
                                            .font(.subheadline)
                                        HStack {
                                            Text("Bought: \(Int(data.totalBought))")
                                                .foregroundColor(.green)
                                            Text("Sold: \(Int(data.totalSold))")
                                                .foregroundColor(.red)
                                        }
                                    }
                                    .padding()
                                    .background(data == selectedPeriod ? Color.blue.opacity(0.3) : Color.gray.opacity(0.2))
                                    .cornerRadius(8)
                                }
                            }
                        }
                        .padding()
                    }

                   
                    if let selectedData = selectedPeriod {
                        ChartView(insiderData: [selectedData])
                            .frame(height: 300)
                            .padding()
                    } else {
                        Text("Please select a period to view the graph.")
                            .padding()
                    }
                } else {
                    Text("No data available. Please enter a valid ticker.")
                        .padding()
                }
            }
            .onAppear {
                viewModel.fetchData(for: ticker)  
            }
            .navigationTitle("Insider Trading Data")
        }
    }
}



#Preview {
    ContentView()
}
