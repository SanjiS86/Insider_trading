//
//  SentimentChartView.swift
//  InsiderTradingStats
//
//  Created by Sanzhi Kobzhan on 19.09.2024.
//
import SwiftUI
import Charts

struct SentimentChartView: View {
    let sentimentData: [SocialSentimentData]
    
    @State private var displayedDataCount = 30
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    Chart {
                        ForEach(sentimentData.prefix(displayedDataCount), id: \.id) { data in
                            LineMark(
                                x: .value("Date", data.date),
                                y: .value("Twitter Sentiment", data.twitterSentiment)
                            )
                            .foregroundStyle(.blue)
                            PointMark(
                                x: .value("Date", data.date),
                                y: .value("Twitter Sentiment", data.twitterSentiment)
                            )
                            .foregroundStyle(.red)
                            .symbolSize(100)
                            .annotation(position: .top) {
                                                            Text(extractTime(from: data.date))
                                                                .font(.caption)
                                                                .foregroundColor(.gray)
                                                        }
                            .annotation(position: .bottom) {
                                    Text("Sentiment: \(data.twitterSentiment, specifier: "%.2f")")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                        }
                    }
                    .frame(width: CGFloat(displayedDataCount) * 80, height: 300)
                }
                .onAppear {
                    DispatchQueue.main.async {
                        if let lastData = sentimentData.last {
                            proxy.scrollTo(lastData.id, anchor: .trailing)
                        }
                    }
                }
            }
        }
        .gesture(DragGesture().onEnded { value in
            if value.translation.width > 0 {
                loadMoreData()
            }
        })
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        .chartXAxis {
            AxisMarks(values: sentimentData.prefix(displayedDataCount).map { $0.date })
        }
    }
  
    private func loadMoreData() {
        let newCount = displayedDataCount + 10
        if newCount <= sentimentData.count {
            displayedDataCount = newCount
        }
    }
    private func extractTime(from dateString: String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let date = dateFormatter.date(from: dateString) {
                let timeFormatter = DateFormatter()
                timeFormatter.dateFormat = "HH:mm"  
                return timeFormatter.string(from: date)
            }
            return ""
        }
    
}


