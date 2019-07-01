//
//  AlgoCoinChange.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/1/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class AlgoNumberOfWaysForChange: Runnable {
    func runTests() {
        let solution = NumberOfWaysForChange()
        print(solution.numberOfWaysToMakeChange(n: 7, denoms: [1, 5]))
    }
    
    private class NumberOfWaysForChange {
        func numberOfWaysToMakeChange(n: Int, denoms: [Int]) -> Int {
            var dp = [Int](repeating: 0, count: n + 1)
            dp[0] = 1
            dp[1] = 1
            
            for i in 2...n {
                for demon in denoms {
                    if i >= demon {
                        dp[i] += dp[i-demon]
                    }
                }
            }
            return dp[n]
        }
    }
}
