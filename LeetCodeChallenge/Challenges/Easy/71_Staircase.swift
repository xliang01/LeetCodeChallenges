//
//  71_Staircase.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/12/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class ClimbingStairs: Runnable {
    func runTests() {
        let solution = Solution()
        print (solution.climbStairs(5))
    }
    
    private class Solution {
        func climbStairs(_ n: Int) -> Int {
            guard n > 1 else { return 1 }
            var dp = [Int](repeating: 1, count: n+1)
            for i in 2...n {
                dp[i] = dp[i-1] + dp[i-2]
            }
            return dp[n]
        }
    }
}
