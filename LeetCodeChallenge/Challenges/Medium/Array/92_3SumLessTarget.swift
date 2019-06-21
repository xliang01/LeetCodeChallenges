//
//  92_3SumLessTarget.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/21/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class ThreeSumLessTarget: Runnable {
    
    func runTests() {
        let solution = SolutionSumVariation()
        print(solution.threeSumSmaller([3,1,0,-2,5], 6))
    }
    
    private class SolutionSumVariation {
        func threeSumSmaller(_ nums: [Int], _ target: Int) -> Int {
            if nums.count < 3 { return 0 }
            // Sort the array. This ensures we can use pointers to determine if the pairs are bigger or smaller.
            var nums = nums.sorted()
            var count = 0
            // Instead of trying to calculate the target, we can do a complement. This complement / is target - number.
            for i in 0..<nums.count - 2 {
                count += smaller(nums, i+1, target - nums[i])
            }
            return count
        }
        
        func smaller(_ nums:[Int], _ start: Int, _ target: Int) -> Int {
            var count = 0
            var left = start
            var right = nums.count - 1
            
            // For each pair, determine if its sum is less than the target.
            while left < right {
                let sum = nums[left] + nums[right]
                /**
                    If this pair is less than the target, it means EVERY pair, using array[left], from left+1 to right is less than target,
                    where array[left]+array[left+1], array[left]+array[left+2], array[left]+array[left+3] ... will always be smaller
                    than the target.
                */
                if sum < target {
                    count += right - left
                    left += 1
                }
                else {
                    right -= 1
                }
            }
            return count
        }
    }
}
