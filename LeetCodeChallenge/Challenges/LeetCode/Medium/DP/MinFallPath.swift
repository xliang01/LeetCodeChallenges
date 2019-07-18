//
//  MinFallPath.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/16/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class MinFallPath: Runnable {
    func runTests() {
        let solution = SolutionDP()
        print(solution.minFallingPathSum([[-51,-35,74],
                                          [-62,14,-53],
                                          [94,61,-10]]))
    }
    
    private class SolutionDP {
        func minFallingPathSum(_ A: [[Int]]) -> Int {
            var A = A
            var row = A.count-2
            
            while row >= 0 {
                for col in 0..<A[0].count {
                    let currentCost = A[row+1][col]
                    if col == 0 {
                        A[row][col] += min(currentCost, A[row+1][col+1])
                    }
                    else if col == A[0].count - 1 {
                        A[row][col] += min(currentCost, A[row+1][col-1])
                    }
                    else {
                        A[row][col] += min(A[row+1][col-1], currentCost, A[row+1][col+1])
                    }
                }
                row -= 1
            }
            
            var minCost = Int.max
            for cost in A[0] {
                minCost = min(minCost, cost)
            }
            return minCost
        }
    }
}
