//
//  36_NumberOfCombinations.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 5/5/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

/**
    Given a set of m distinct positive integers and a value ‘N’. The problem is to count the total number of ways we can form ‘N’ by doing sum of the array elements. Repetitions and different arrangements are allowed.
 */

class NumberOfCombinations: Runnable {
    func runTests() {
        let solution1 = SolutionTopDownMemoize()
        print(solution1.getCombination(4, [1, 3, 5]))
        
        let solution2 = SoutionBottomUp()
        print(solution2.getCombination(4, [1, 3, 5]))
    }
    
    private class SolutionTopDownMemoize {
        func getCombination(_ n: Int, _ combinations: [Int]) -> Int {
            var dp = [Int](repeating: -1, count: n+1)
            return solve(n, &dp, combinations)
        }
        
        // this function returns the number of
        // arrangements to form 'n'
        func solve(_ n: Int, _ dp: inout [Int], _ combinations: [Int]) -> Int {
            // Base case
            if n < 0 { return 0 }
            if (n == 0) { return 1 }
            
            // Checking if already calculated
            if (dp[n] != -1) {
                return dp[n]
            }
            
            // Storing the result and returning
            var sum = 0
            combinations.forEach { combination in
                sum += solve(n-combination, &dp, combinations)
            }
            dp[n] = sum
//            dp[n] = solve(n-1, &dp) + solve(n-3, &dp) + solve(n-5, &dp)
            return dp[n]
        }
    }
    
    private class SoutionBottomUp {
        /**
         [1, 3, 5], 1,2,3,4,5,6 if N = 6
         0
            0               (1 ways)
         1                  (1 ways)
            1
         2                  (1 ways)
            1 + 1
         3                  (2 ways)
            1 + 1 + 1
            3
         4                  (3 ways)
            1 + 1 + 1 + 1
            3 + 1
            1 + 3
         5                  (4 ways)
            1 + 1 + 1 + 1 + 1
            3 + 1 + 1
            1 + 3 + 1
            1 + 1 + 3
         6                  (8 ways)
            1 + 1 + 1 + 1 + 1 + 1
            3 + 1 + 1 + 1
            1 + 3 + 1 + 1
            1 + 1 + 3 + 1
            5 + 1
            1 + 1 + 1 + 3
            3 + 3
            1 + 5
         */
        
        func getCombination(_ n: Int, _ combinations: [Int]) -> Int {
            var count = [Int](repeating: 0, count: n + 1)
            count[0] = 1
            
            for subCount in (1...n) {
                for i in (0..<combinations.count) {
                    if subCount >= combinations[i] {
                        count[subCount] = count[subCount] + count[subCount - combinations[i]]
                    }
                }
            }
            
            return count[n]
        }
    }
}
