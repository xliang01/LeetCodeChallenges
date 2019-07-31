//
//  LargestUniqueNumber.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/30/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class LargestUniqueNumber: Runnable {
    func runTests() {
        let solution1 = SolutionMap()
        print(solution1.largestUniqueNumber([5,7,3,9,4,9,8,3,1]))
        
        let solution2 = SolutionArray()
        print(solution2.largestUniqueNumber([5,7,3,9,4,9,8,3,1]))
    }
    
    /**
         T: O(N)
         S: O(N)
     */
    private class SolutionMap {
        func largestUniqueNumber(_ A: [Int]) -> Int {
            var max = -1
            var counts = [Int: Int]()
            
            for n in A {
                counts[n, default: 0] = (counts[n] ?? 0) + 1
            }
            
            for (n, count) in counts {
                if count == 1 && n > max {
                    max = n
                }
            }
            return max
        }
    }
    
    private class SolutionArray {
        func largestUniqueNumber(_ A: [Int]) -> Int {
            var numCounts = [Int](repeating: 0, count: 1001)
            
            for n in A {
                numCounts[n] += 1
            }
            
            for n in numCounts.indices.reversed() {
                let count = numCounts[n]
                if count == 1 {
                    return n
                }
            }
            return -1
        }
    }
}
