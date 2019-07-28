//
//  LongestOnes.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/23/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class LongestOnes: Runnable {
    func runTests() {
        let solution = SolutionWindow()
        print(solution.longestOnes([0,0,1,1,0,0,1,1,1,0,1,1,0,0,0,1,1,1,1], 3))
    }
    
    /**
        T: 
    */
    private class SolutionWindow {
        func longestOnes(_ A: [Int], _ K: Int) -> Int {
            var length = 0
            var start = 0
            var end = 0
            var zeroes = 0
            
            while end < A.count && start <= end {
                if A[end] == 0 {
                    zeroes += 1
                }
                
                while zeroes > K {
                    if A[start] == 0 {
                        zeroes -= 1
                    }
                    start += 1
                }
                
                length = max(length, end - start + 1)
                end += 1
            }
            
            return length
        }
    }
}
