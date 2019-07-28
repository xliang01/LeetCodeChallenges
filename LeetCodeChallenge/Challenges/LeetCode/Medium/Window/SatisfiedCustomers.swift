//
//  SatisfiedCustomers.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/23/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class SatisfiedCustomers: Runnable {
    func runTests() {
        let solution = SolutionSlidingWindow()
//        print(solution.maxSatisfied([1,0,1,2,1,1,7,5], [0,1,0,1,0,1,0,1], 3))
        print(solution.maxSatisfied([4, 10, 10], [1, 1, 0], 2))
    }
    
    private class SolutionSlidingWindow {
        func maxSatisfied(_ customers: [Int], _ grumpy: [Int], _ X: Int) -> Int {
            var maxGrumpy = 0
            var maxGrumpyIdx = Int.min
            
            for grumpyIdx in grumpy.indices {
                if grumpy[grumpyIdx] == 1 {
                    var grumpySum = 0
                    var window = grumpyIdx
                    while window < (grumpyIdx + X) && window < grumpy.count {
                        grumpySum += customers[window]
                        window += 1
                    }
                    
                    if grumpySum > maxGrumpy {
                        maxGrumpy = grumpySum
                        maxGrumpyIdx = grumpyIdx
                    }
                }
            }
            
            var satisfaction = 0
            for (i, c) in customers.enumerated() {
                if grumpy[i] == 0 {
                    satisfaction += c
                }
                else {
                    satisfaction += 0
                }
            }
            
            return satisfaction + maxGrumpy
        }
    }
}
