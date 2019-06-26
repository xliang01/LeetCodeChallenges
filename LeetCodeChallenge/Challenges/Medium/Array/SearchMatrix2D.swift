//
//  SearchMatrix2D.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/25/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class SearchMatrix2D: Runnable {
    func runTests() {
        
    }
    
    private class SolutionRecursion {
        func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
            if matrix.isEmpty { return false }
            return search(matrix, 0, 0, matrix[0].count-1, matrix.count-1, target)
        }
        
        private func search(_ matrix: [[Int]], _ left: Int, _ up: Int, _ right: Int, _ down: Int, _ target: Int) -> Bool {
            if left > right || up > down {
                return false
            }
            
            if target < matrix[up][left] || matrix[down][right] < target {
                return false
            }
            
            let mid = (left + right) / 2
            var row = up
            while row <= down && matrix[row][mid] <= target {
                if matrix[row][mid] == target { return true }
                row += 1
            }
            
            return search(matrix, left, row, mid - 1, down, target) || search(matrix, mid + 1, up, right, row - 1, target)
        }
    }
    
    private class SolutionIterative {
        func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
            if matrix.isEmpty { return false }
            let m = matrix.count
            let n = matrix[0].count
            
            var r = m - 1
            var c = 0
            
            while r >= 0 && c < n {
                let val = matrix[r][c]
                if val == target { return true }
                if val < target {
                    c += 1
                }
                else {
                    r -= 1
                }
            }
            
            return false
        }
    }
}
