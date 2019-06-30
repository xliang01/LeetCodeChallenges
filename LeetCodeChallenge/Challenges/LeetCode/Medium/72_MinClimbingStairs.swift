//
//  72_MinClimbStairs.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/12/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class MinClimbingStairs: Runnable {
    func runTests() {
        let solution = SolutionDP()
//        print(solution.minCostClimbingStairs([0,0,0,0]))
//        print(solution.minCostClimbingStairs([0,0,1,1]))
//        print(solution.minCostClimbingStairs([10,15,20]))
        print(solution.minCostClimbingStairs([1,100,1,1,1,100,1,1,100,1]))
        // dp [0,0,0,0,0,0,0,0,0,1]
        // i = 9
            // [0,0,0,0,0,0,0,2,2,2]
        // i = 6
            // [0,0,0,0,0,0,0,2,2,2]
    }
    
    private class SolutionDP {
        func minCostClimbingStairs(_ cost: [Int]) -> Int {
            var dp = cost
            
            for i in 2 ..< cost.count {
                dp[i] += min(dp[i - 1], dp[i - 2])
            }
            return min(dp[dp.count - 1], dp[dp.count - 2])
        }
    }
}
