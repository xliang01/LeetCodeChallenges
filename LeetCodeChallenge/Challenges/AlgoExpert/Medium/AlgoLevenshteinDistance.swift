//
//  AlgoLevenshteinDistance.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/5/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class AlgoLevenshteinDistance: Runnable {
    func runTests() {
        let solution = SolutionDP()
        print(solution.levenshteinDistance("abc", "yabd"))
        print(solution.levenshteinDistance("aa", "a"))
        print(solution.levenshteinDistance("a", "aa"))
        print(solution.levenshteinDistance("", "aa"))
    }
    
    private class SolutionDP {
        func levenshteinDistance(_ s1: String, _ s2: String) -> (Int, [String]) {
            if s1.isEmpty && s2.isEmpty { return (0, []) }
            let s1 = Array<Character>(s1)
            let s2 = Array<Character>(s2)
            
            var dp = [[Int]](repeating: [Int](repeating: 0, count: s1.count + 1), count: s2.count + 1)
            for col in 0..<dp[0].count {
                dp[0][col] = col
            }
            for row in 0..<dp.count {
                dp[row][0] = row
            }
            
            var row = 1
            var col = 1
            while row <= s2.count {
                while col <= s1.count {
                    if s1[col-1] != s2[row-1] {
                        dp[row][col] += min(dp[row-1][col-1], dp[row-1][col], dp[row][col-1]) + 1
                    }
                    else {
                        dp[row][col] += dp[row-1][col-1]
                    }
                    col += 1
                }
                row += 1
            }
            
            let minChanges = dp[s2.count][s1.count]
            
            row = s2.count - 1
            col = s1.count - 1
            
            var ops = [String]()
            while row >= 0 && col >= 0 {
                if s2[row] != s1[col] {
                    ops.append("Substitude \(s1[col]) for \(s2[row])")
                }
                
                row -= 1
                col -= 1
            }
            
            if col > row {
                while col >= 0 {
                    ops.append("Remove \(s1[col])")
                    col -= 1
                }
            }
            else if row > col{
                while row >= 0 {
                    ops.append("Insert \(s2[row])")
                    row -= 1
                }
            }
            
            return (minChanges, ops.reversed())
        }
    }
}
