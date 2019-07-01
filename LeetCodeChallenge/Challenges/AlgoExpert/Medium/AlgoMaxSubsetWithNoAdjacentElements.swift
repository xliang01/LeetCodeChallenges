//
//  MaxSubsetWithNoAdjacentElements.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/1/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class AlgoMaxSubsetWithNoAdjacentElements: Runnable {
    func runTests() {
        let solution = MaxSubsetWithNoAdjacentElement()
        print(solution.maxSubsetSumNoAdjacent(array: [75, 105, 120, 75, 90, 135]))
    }
    
    private class MaxSubsetWithNoAdjacentElement {
        // This is the classic house robber question.
        func maxSubsetSumNoAdjacent(array: [Int]) -> Int {
            if array.isEmpty { return 0 }
            var dp = [Int](repeating: 0, count: array.count)
            
            // If there's only one element, choose it.
            dp[0] = array[0]
            // If there are two elements, chose the max.
            dp[1] = max(array[0], array[1])
            // If there are three elements, choose either the current and the choice 2 behind, or the last one.
            for i in 2..<array.count {
                dp[i] = max(array[i] + dp[i-2], dp[i-1])
            }
            // Get the max of possible choices.
            return dp[array.count-1]
        }
    }
}
