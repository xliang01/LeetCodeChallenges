//
//  SetMatrixZeroes.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/25/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class SetMatrixZeroes: Runnable {
    func runTests() {
        var input1 = [
            [1,1,1],
            [1,0,1],
            [1,1,1]
        ]
        let solution1 = SolutionUseSet()
        solution1.setZeroes(&input1)
        print(input1)
        
        var input2 = [
            [1,1,1],
            [1,0,1],
            [1,1,1]
        ]
        let solution2 = SolutionUseMatrix()
        solution2.setZeroes(&input2)
        print(input2)
    }
    
    private class SolutionUseSet {
        func setZeroes(_ matrix: inout [[Int]]) {
            var rSet = Set<Int>()
            var cSet = Set<Int>()
            
            for r in 0..<matrix.count {
                for c in 0..<matrix[0].count {
                    if matrix[r][c] == 0 {
                        rSet.insert(r)
                        cSet.insert(c)
                    }
                }
            }
            
            for r in 0..<matrix.count {
                for c in 0..<matrix[0].count {
                    if rSet.contains(r) || cSet.contains(c) {
                       matrix[r][c] = 0
                    }
                }
            }
        }
    }
    
    private class SolutionUseMatrix {
        func setZeroes(_ matrix: inout [[Int]]) {
            if matrix.isEmpty { return }
            
            var zeroFirstRowAndCol = false
            for r in 0..<matrix.count {
                if matrix[r][0] == 0 {
                    zeroFirstRowAndCol = true
                }
            }
            
            for r in 0..<matrix.count {
                for c in 1..<matrix[0].count {
                    if matrix[r][c] == 0 {
                        matrix[0][c] = 0
                        matrix[r][0] = 0
                    }
                }
            }
            
            for r in 1..<matrix.count {
                for c in 1..<matrix[0].count {
                    if matrix[0][c] == 0 || matrix[r][0] == 0 {
                        matrix[r][c] = 0
                    }
                }
            }
            
            if matrix[0][0] == 0 {
                for c in 0..<matrix[0].count {
                    matrix[0][c] = 0
                }
            }
            
            if zeroFirstRowAndCol {
                for r in 0..<matrix.count {
                    matrix[r][0] = 0
                }
            }
        }
    }
}
