//
//  95_UniquePaths2.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/21/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class UniquePathsPart2: Runnable {
    func runTests() {
        let solution1 = SolutionDP()
        print(solution1.uniquePathsWithObstacles([]))
    }
    
    private class SolutionDP {
        func uniquePathsWithObstacles(_ obstacleGrid: [[Int]]) -> Int {
            // If the grid is empty, return nothing
            if obstacleGrid.isEmpty { return 0 }
            
            // Get the row count
            let m = obstacleGrid.count
            
            // Get the col count
            let n = obstacleGrid[0].count
            
            // Build the DP table
            var dp = [[Int]](repeating: [Int](repeating: 0, count: n), count: m)
            
            // If the first cell is an obstacle, then 0, else 1.
            dp[0][0] = obstacleGrid[0][0] != 1 ? 1 : 0
            
            // The idea here is to check if any paths at row 0 is possible. If we hit an obstacle, everything else is 0 because we can't go right anymore. To do this, we apply a mask.
            for i in 1..<m {
                let mask = (obstacleGrid[i][0] != 1 ? 1 : 0)
                dp[i][0] = dp[i-1][0] * mask
            }
            
            // Here, we check if we can go down. If there's an obstacle, our base DP table will be 0. To do this, we apply a mask.
            for i in 1..<n {
                let mask = (obstacleGrid[0][i] != 1 ? 1 : 0)
                dp[0][i] = dp[0][i-1] * mask
            }
            
            // Build the DP table. If there's an obstacle, zero the coordinate out. We can no longer go on this path.
            for i in 1..<m {
                for j in 1..<n {
                    let mask = (obstacleGrid[i][j] != 1 ? 1 : 0)
                    dp[i][j] = (dp[i-1][j] + dp[i][j - 1]) * mask
                }
            }
            // Return the end of the DP table.
            return dp[m-1][n-1]
        }
    }
}
