//
//  SocialSentimentView.swift
//  InsiderTradingStats
//
//  Created by Sanzhi Kobzhan on 19.09.2024.
//
import SwiftUI

struct SocialSentimentView: View {
    @StateObject var viewModel = SocialSentimentViewModel()
    @State private var ticker: String = "AAPL"

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter Ticker", text: $ticker)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button(action: {
                        viewModel.fetchSentimentData(for: ticker.uppercased())
                    }) {
                        Text("Fetch Sentiment")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }

                if !viewModel.sentimentData.isEmpty {
                    Text("Twitter Sentiment for \(ticker.uppercased())")
                        .font(.headline)
                        .padding()
                    SentimentChartView(sentimentData: viewModel.sentimentData)
                        .padding()
                    VStack(alignment: .leading) {
                                            Text("What is Twitter Sentiment?")
                                                .font(.headline)
                                                .padding(.top)
                                            
                                            Text("Twitter sentiment measures the overall tone of tweets related to a specific stock. A score typically ranges from 0 to 1")
                                                .padding(.bottom, 5)


                                            Text("If the Twitter sentiment score is below 0.5, it generally indicates that the sentiment is more negative or neutral.")
                                        }
                                        .padding()
                } else {
                    Text("No data available. Please enter a valid ticker.")
                        .padding()
                }
                NavigationLink(destination: ContentView()) {
                                Text("Back to Insider Trading Data")
                                    .font(.headline)
                                    .padding()
                                    .foregroundColor(.blue)
                            }
                            .padding(.bottom)
            }
            .onAppear {
                viewModel.fetchSentimentData(for: ticker)
            }
            .navigationTitle("Social Sentiment Data")
        }
    }
}

#Preview {
    SocialSentimentView()
}
