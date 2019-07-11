//
//  LargestRectangleHistogram.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/10/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class LargestRectangleHistogram: Runnable {
    func runTests() {
        let solution = SolutionRecursiveDivideAndConquer()
        print(solution.largestRectangleArea([6, 4, 5, 2, 4, 3, 9]))
    }
    
    private class SolutionRecursiveDivideAndConquer {
        func largestRectangleArea(_ heights: [Int]) -> Int {
            return largestArea(heights,
                               0,
                               heights.count-1)
        }
        
        private func largestArea(_ heights: [Int],
                                 _ start: Int,
                                 _ end: Int) -> Int {
            if start >= end { return heights[start] }
            
            var minHeight = Int.max
            var minIndex = start
            
            for i in start...end {
                if heights[i] < minHeight {
                    minHeight = heights[i]
                    minIndex = i
                }
            }
            
            let thisMaxArea = (end - start + 1) * minHeight
            return max(largestArea(heights, start, minIndex-1),
                       largestArea(heights, minIndex+1, end),
                       thisMaxArea)
        }
    }
    
    
    private class SolutionIterative {
        func largestRectangleArea(_ heights: [Int]) -> Int {
            var maxArea = Int.min
            for i in 0..<heights.count {
                for j in i..<heights.count {
                    var minHeight = Int.max
                    for k in i...j {
                        minHeight = min(heights[k], minHeight)
                    }
                    maxArea = max(maxArea, (j-i+1) * minHeight)
                }
            }
            return maxArea
        }
    }
    
    private class SolutionIterativeSmallOp {
        func largestRectangleArea(_ heights: [Int]) -> Int {
            var maxArea = Int.min
            for i in 0..<heights.count {
                var minHeight = Int.max
                for j in i..<heights.count {
                    minHeight = min(heights[j], minHeight)
                    maxArea = max(maxArea, (j-i+1) * minHeight)
                }
            }
            return maxArea
        }
    }
}
