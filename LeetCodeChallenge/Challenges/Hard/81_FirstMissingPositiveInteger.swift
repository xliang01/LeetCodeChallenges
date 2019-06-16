//
//  81_FirstMissingPositiveInteger.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/15/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class FirstMissingPositiveInteger: Runnable {
    func runTests() {
        let solution = SolutionInplaceArray()
        print(solution.firstMissingPositive(nums: [1,2,0]))
        print(solution.firstMissingPositive(nums: [3,4,-1,1]))
        print(solution.firstMissingPositive(nums: [7,8,9,11,12]))
        print(solution.firstMissingPositive(nums: [1, 1]))
        print(solution.firstMissingPositive(nums: [2, 1]))
    }
    
    /**
        Very tricky array solution.
     
        When iterating an array, we must loop through and mark all values that are either negative, 0, or out of bounds from N.
        The reason is that these numbers cannot tell us what the next positive number should be. How do we tell?
     
        We loop through the nums and mark every invalid number as 1. This flags that the number is out of bounds or negative or 0.
        Next, for each item that is NOT a 1, meaning they are valid numbers, use the actual number as a index value, and mark that
        index in the array as the negative number. This uses the array as a marker to know which items in the index has been flagged.
     */
    private class SolutionInplaceArray {
        func firstMissingPositive(nums: [Int]) -> Int {
            var oneCount = 0
            for num in nums {
                if num == 1 {
                    oneCount += 1
                }
            }
            
            if oneCount == 0 { return 1 }
            else if oneCount == nums.count { return 2 }
            var nums = nums
            
            for i in 0..<nums.count {
                if nums[i] <= 0 || nums[i] > nums.count {
                    nums[i] = 1
                }
            }
            
            for num in nums {
                // Handle duplicates here to ensure we don't non-negate a number.
                let val = abs(num)
                
                if val == nums.count {
                    nums[0] = -abs(nums[0])
                }
                else {
                    nums[val] = -abs(nums[val])
                }
            }
            
            for i in 1..<nums.count {
                if nums[i] > 0 {
                    return i
                }
            }
            
            if nums[0] > 0 {
                return nums.count
            }
            
            
            return nums.count + 1
        }
    }
}
