//
//  main.swift
//  LeetCodeChallenges
//
//  Created by Xiao Liang on 3/18/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

/*
     Given an array of integers, return indices of the two numbers such that they add up to a specific target.
     You may assume that each input would have exactly one solution, and you may not use the same element twice.
 
     Example:
 
     Given nums = [2, 7, 11, 15], target = 9,
 
     Because nums[0] + nums[1] = 2 + 7 = 9,
     return [0, 1].
 */

class Solution {
    // MARK: First Solution
    
    func twoSum1(_ nums: [Int], _ target: Int) -> [Int] {
        // Base Case
        guard nums.count >= 2 else {
            return nums
        }
        
        // Brute Force
        // Time Complexity: O(n^2)
        for i in (0..<nums.count) {
            for j in (i..<nums.count) {
                if nums[i] + nums[j] == target, i != j {
                    return [i, j]
                }
            }
        }
        
        return []
    }
    
    // MARK: Best Solution
    
    func twoSum2(_ nums: [Int], _ target: Int) -> [Int] {
        // Base Case
        guard nums.count >= 2 else {
            return nums
        }
        
        /**
             Iterate through the array and store the value as the hash and its index as the value. This ensures
             a fast hash lookup to determine if the complement number exists in the array.
         */
        var hash = [Int: Int]()
        for (index, value) in nums.enumerated() {
            hash[value] = index
        }
        
        /**
             Iterate through the array and look for the index of the complement (the difference) in the hashmap.
             Because there is only one solution in the entire array, finding the complement will immediately
             solve the problem.
         
             Edge case: The only issue is when the complement's index is equal to the value of the current index.
             This is NOT the solution because TWO unique indices must be returned. This occurs when the comlement
             is exactly 1/2 times the target value, which means the value is in the hash is equal to the value of
             the current index. Therefore, we must ensure the current index does not equal the hashmap's index.
         */
        for (index, value) in nums.enumerated() {
            let difference = target - value
            if let foundIndex = hash[difference], foundIndex != index {
                return [index, foundIndex]
            }
        }
        
        return []
    }
}


let nums = [3,2,4]
let target = 6

print(Solution().twoSum1(nums, target))
print(Solution().twoSum2(nums, target))
