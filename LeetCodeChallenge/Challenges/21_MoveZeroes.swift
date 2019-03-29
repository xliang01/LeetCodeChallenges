//
//  21_MoveZeroes.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 3/28/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class MoveZeroes: Runnable {
    func runTests() {
        var input = [2, 1]
        let solution1 = SolutionIndex()
        solution1.moveZeroes(&input)
        print(input)
        
        input = [0,1,0,3,12]
        let solution2 = SolutionIndexFaster()
        solution2.moveZeroes(&input)
        print(input)
    }
    
    private class SolutionIndex {
        func moveZeroes(_ nums: inout [Int]) {
            for i in (0..<nums.count) {
                if nums[i] == 0 {
                    if i == nums.count - 1 {
                        return
                    }
                    for j in (i + 1..<nums.count) {
                        if nums[j] != 0 {
                            nums[i] = nums[j]
                            nums[j] = 0
                            break
                        }
                    }
                }
            }
        }
    }
    
    private class SolutionIndexFaster {
        /**
            Solution:
         
            Use two pointers for knowing where to swap. Use a sub pointer to keep track of the final array's index where all non-zeroes are
            going to be placed. Use another iterator pointer to go through the array. Swap the iterator index with the sub index if a non
            zero value is found.
         
            Performance:
         
            Runtime Complexity: O(N) because we are iterating through the array once.
            Space Complexity: O(1) because no data structures are used.
         */
        func moveZeroes(_ nums: inout [Int]) {
            var subIndex = 0
            for i in (0..<nums.count) {
                if nums[i] != 0 {
                    let temp = nums[subIndex]
                    nums[subIndex] = nums[i]
                    nums[i] = temp
                    subIndex += 1
                }
            }
        }
    }
}
