//
//  AlgoWaterArea.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/6/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class AlgoWaterArea: Runnable {
    func runTests() {
        let solution = SolutionArrayMatch()
        print(solution.waterArea([0, 8, 0, 0, 5, 0, 0, 10, 0, 0, 1, 1, 0, 3]))
        print(solution.waterArea2([0, 8, 0, 0, 5, 0, 0, 10, 0, 0, 1, 1, 0, 3]))
    }
    
    private class SolutionArrayMatch {
        func waterArea2(_ heights: [Int]) -> Int {
            if heights.count < 3 { return 0 }
            var maxRight = [Int](repeating: 0, count: heights.count)
            var maxLeft = [Int](repeating: 0, count: heights.count)
            
            maxRight[0] = 0
            maxLeft[heights.count-1] = 0
            
            for i in 1..<heights.count {
                maxRight[i] = max(heights[i-1], maxRight[i-1])
            }
            for i in stride(from: heights.count-2, through: 0, by: -1) {
                maxLeft[i] = max(heights[i+1], maxLeft[i+1])
            }
            var area = 0
            for i in 0..<heights.count {
                let minHeight = min(maxRight[i], maxLeft[i])
                if heights[i] < minHeight {
                    area += min(maxRight[i], maxLeft[i]) - heights[i]
                }
            }
            return area
        }
        func waterArea(_ heights: [Int]) -> Int {
            if heights.count < 3 { return 0 }
            
            var areaHeights = [Int](repeating: 0, count: heights.count)
            areaHeights[0] = heights[0]
            
            // Scan right to find the tallest wall from that point of i - 1
            for i in 1..<heights.count {
                areaHeights[i] = max(areaHeights[i-1], heights[i])
            }
            // Scan left to find the smallest wall
            let end = heights.count - 1
            areaHeights[end] = min(areaHeights[end], heights[end])
            for i in stride(from: heights.count - 2, through: 0, by: -1) {
                if areaHeights[i] > heights[i+1] {
                    areaHeights[i] = min(areaHeights[i], areaHeights[i+1])
                }
            }
            
            var totalArea = 0
            for i in heights.indices {
                if heights[i] < areaHeights[i] {
                    totalArea += areaHeights[i] - heights[i]
                }
            }
            return totalArea
        }
    }
}
