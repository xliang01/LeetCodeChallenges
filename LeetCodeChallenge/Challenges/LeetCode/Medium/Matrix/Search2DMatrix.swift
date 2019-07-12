//
//  Search2DMatrix.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/11/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class Search2DMatrix: Runnable {
    func runTests() {
        print(Int32.max)
        let matrix = [
            [1,   3,  5,  7],
            [10, 11, 16, 20],
            [23, 30, 34, 50]
        ]
        
        let solution = SolutionBinarySearch()
        print(solution.searchMatrix(matrix, 3))
        print(solution.searchMatrix(matrix, 13))
    }
    
    class SolutionBinarySearch {
        func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
            var start = 0
            let m = matrix.count
            let n = matrix[0].count
            let len = m * n
            var end = len - 1
            
            while start <= end {
                let mid = (start + end) / 2
                let row = mid / n
                let col = mid % n
                
                let val = matrix[row][col]
                if val == target { return true }
                else if target < val { end = mid - 1}
                else { start = mid + 1 }
            }
            return false
        }
    }
    
    class SolutionWalkArray {
        func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
            var row = matrix.count - 1
            var col = 0
            
            while row >= 0 && col <= matrix[0].count-1 {
                if matrix[row][col] == target {
                    return true
                }
                else if matrix[row][col] > target {
                    row -= 1
                }
                else {
                    col += 1
                }
            }
            
            return false
        }
    }
}
