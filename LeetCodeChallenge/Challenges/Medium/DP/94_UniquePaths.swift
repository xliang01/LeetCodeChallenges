//
//  94_UniquePaths.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/21/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class UniquePaths: Runnable {
    func runTests() {
        let solution1 = SolutionMemoizeDFS()
        print(solution1.uniquePaths(3, 2))
        
        let solution2 = SolutionMemoizeDFS()
        print(solution2.uniquePaths(3, 2))
    }
    
    private class SolutionDP {
        func uniquePaths(_ m: Int, _ n: Int) -> Int {
            var dp = [[Int]](repeating: [Int](repeating: n, count: 0), count: n)
            for r in 0..<m {
                dp[r][0] = 1
            }
            
            for c in 0..<n {
                dp[0][c] = 1
            }
            
            for r in 1..<m {
                for c in 1..<n {
                    dp[r][c] = dp[r-1][c] + dp[r][c-1]
                }
            }
            return dp[m-1][n-1]
        }
    }
    
    private class SolutionMemoizeDFS {
        func uniquePaths(_ m: Int, _ n: Int) -> Int {
            var mem = [[Int?]](repeating: [Int?](repeating: nil, count: n), count: m)
            return dfs(m, n, 0, 0, &mem)
        }
        
        func dfs(_ m: Int,
                 _ n: Int,
                 _ r: Int,
                 _ c: Int,
                 _ mem: inout [[Int?]]) -> Int {
            if r == m-1 && c == n-1 {
                return 1
            }
            
            if r >= m || c >= n {
                return 0
            }
            
            if let counts = mem[r][c] {
                return counts
            }
            
            // Move right
            let rightC = c + 1
            let rightR = r + 0
            
            // Move down
            let downC = c + 0
            let downR = r + 1
            
            let rightCount = dfs(m, n, rightR, rightC, &mem)
            let downCount = dfs(m, n, downR, downC, &mem)
            
            mem[r][c] = rightCount + downCount
            return mem[r][c]!
        }
    }
}
