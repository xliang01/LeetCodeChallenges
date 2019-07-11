//
//  AllPermutationsOfANumber.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/10/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class AllPermutationsOfANumber: Runnable {
    func runTests() {
        let solution = SolutionRecursiveBacktrack()
        print(solution.permutations([1,2,3]))
    }
    
    private class SolutionRecursiveBacktrack {
        func permutations(_ nums: [Int]) -> [[Int]] {
            var nums = nums
            var combos = [[Int]]()
            
            permutations(&nums,
                         0,
                         &combos)
            return combos
        }
        
        func permutations(_ nums: inout [Int],
                          _ index: Int,
                          _ combos: inout [[Int]]) {
            if index == nums.count {
                combos.append(nums)
                return
            }
            
            for i in index..<nums.count {
                swap(&nums, index, i)
                permutations(&nums,
                             index + 1,
                             &combos)
                swap(&nums, index, i)
            }
        }
        
        func swap(_ nums: inout [Int],
                  _ i: Int,
                  _ j: Int) {
            let temp = nums[i]
            nums[i] = nums[j]
            nums[j] = temp
        }
    }
}
