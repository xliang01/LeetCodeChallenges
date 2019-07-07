//
//  FindLargestSquare.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/7/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class FindLargestSquare: Runnable {
    func runTests() {
        let solution = SolutionDP()
        
        let matrix1 =
            [
                [1, 0, 1, 1, 1],
                [1, 0, 1, 1, 1],
                [1, 1, 1, 1, 1],
                [1, 0, 0, 1, 0]
            ]
            .map { $0.map { Character(String($0)) } }
        
        let matrix2 =
            [
                [0]
            ]
            .map { $0.map { Character(String($0)) } }
        
        print(solution.maximalSquare(matrix1))
    }
    
    private class SolutionDP {
        func maximalSquare(_ matrix: [[Character]]) -> Int {
            var dp = [[Int]](repeating: [Int](repeating: 0, count: matrix[0].count + 1), count: matrix.count + 1)
            var maxSize = 0
            for row in 1..<dp.count {
                for col in 1..<dp[0].count {
                    if matrix[row-1][col-1] == "1" {
                        let maxSizeOfSquare = min(dp[row-1][col], dp[row-1][col-1], dp[row][col-1]) + 1
                        dp[row][col] = maxSizeOfSquare
                        maxSize = max(maxSize, maxSizeOfSquare)
                    }
                }
            }
            
            return maxSize * maxSize
        }
    }
    
    private class SolutionRecursion {
        func maximalSquare(_ matrix: [[Character]]) -> Int {
            if matrix.isEmpty { return 0 }
            else if matrix.count == 1 { return matrix[0][0] == "1" ? 1 : 0 }
            
            var maxSize = Int.min
            maximalSquare(matrix,
                          0,
                          0,
                          &maxSize)
            return maxSize * maxSize
        }
        
        @discardableResult
        private func maximalSquare(_ matrix: [[Character]],
                                   _ row: Int,
                                   _ col: Int,
                                   _ maxSize: inout Int) -> Int {
            if row == matrix.count - 1 || col == matrix[0].count - 1 {
                return Int(String(matrix[row][col]))!
            }
            
            let right = maximalSquare(matrix, row, col + 1, &maxSize)
            let bottom = maximalSquare(matrix, row + 1, col, &maxSize)
            let bottomRight = maximalSquare(matrix, row + 1, col + 1, &maxSize)
            
            var size = 0
            if matrix[row][col] == "1" {
                size = min(right, bottom, bottomRight) + 1
            }
            
            maxSize = max(maxSize, size)
            return size
        }
    }
}
