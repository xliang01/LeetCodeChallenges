//
//  61_MultiplyVectors.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/8/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class MultiplyVectors: Runnable {
    func runTests() {
        let solution = SolutionArray()
        let v1: [(Int, Float)] = [(0, 4.0), (2, 3.0), (5, 10.0)]
        let v2: [(Int, Float)] = [(1, 4.0), (2, 3.0), (3, 1.0), (4, 1.0)]
        print(solution.multiply(v1: v1, v2: v2))
    }
    
    private class SolutionArray {
        func multiply(v1: [(Int, Float)], v2: [(Int, Float)]) -> Float {
            var v1Index = 0
            var v2Index = 0
            var product = Float(0.0)
            
            while v1Index < v1.count && v2Index < v2.count {
                let v1Tuple = v1[v1Index]
                let v2Tuple = v2[v2Index]
                
                if v1Tuple.0 == v2Tuple.0 {
                    product += (v1Tuple.1 * v2Tuple.1)
                    v1Index += 1
                    v2Index += 1
                }
                else if v1Tuple.0 < v2Tuple.0 {
                    v1Index += 1
                }
                else {
                    v2Index += 1
                }
            }
            
            return product
        }
    }
}
