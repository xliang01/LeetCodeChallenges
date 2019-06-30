//
//  Num_Squares.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/22/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class NumSquares: Runnable {
    func runTests() {
        let solution = SolutionDP()
        print(solution.numSquares(13))
    }
    
    // http://yucoding.blogspot.com/2016/12/leetcode-question-perfect-square.html
    private class SolutionDP {
        func numSquares(_ n: Int) -> Int {
            if n == 0 { return 0 }
            var dp = [Int](repeating: Int.max, count: n + 1)
            dp[0] = 0
            
            for i in 1...n {
                for squares in 1...i where (squares * squares <= i) {
                    dp[i] = min(dp[i], dp[i - (squares * squares)] + 1)
                }
            }
            return dp[n]
        }
    }
}
