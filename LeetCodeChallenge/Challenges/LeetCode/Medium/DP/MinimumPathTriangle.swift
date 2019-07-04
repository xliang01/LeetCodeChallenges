//
//  MinimumPathTriangle.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/4/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class MinimumPathTriange: Runnable {
    func runTests() {
        let solution = SolutionDP()
        let input = [
            [2],
            [3,4],
            [6,5,7],
            [4,1,8,3]
        ]
        print(solution.minimumTotal(input))
    }
    
    private class SolutionDP {
        func minimumTotal(_ triangle: [[Int]]) -> Int {
            if triangle.count == 0 {
                return 0
            }
            
            if triangle.count == 1 {
                return triangle[0][0]
            }
            
            let rowCount = triangle.count
            var dp = [Int](repeating: 0, count: rowCount + 1)
            
            for row in stride(from: rowCount - 1, through: 0, by: -1) {
                for col in 0..<triangle[row].count {
                    dp[col] = triangle[row][col] + min(dp[col], dp[col+1])
                }
            }
            
            return dp[0]
        }
    }
}
