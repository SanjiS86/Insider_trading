//
//  ChartView.swift
//  InsiderTradingStats
//
//  Created by Sanzhi Kobzhan on 18.09.2024.
//
import SwiftUI
import Charts

struct ChartView: View {
    let insiderData: [InsiderData]
    
    var body: some View {
        Chart {
            ForEach(insiderData) { data in
               
                PointMark(
                    x: .value("Quarter", "\(data.year) Q\(data.quarter)"),
                    y: .value("Total Bought", data.totalBought)
                )
                .foregroundStyle(.green)
                .symbolSize(200)
                
              
                PointMark(
                    x: .value("Quarter", "\(data.year) Q\(data.quarter)"),
                    y: .value("Total Sold", data.totalSold)
                )
                .foregroundStyle(.red)
                .symbolSize(200) 
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        .chartXAxis {
            AxisMarks(values: Array(insiderData.indices))
        }
    }
}
