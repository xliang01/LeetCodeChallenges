//
//  SubarraySort.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/30/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class SubarraySort: Runnable {
    func runTests() {
        let solution = SolutionArrayIteration()
        print(solution.subarraySort(nums: [1, 2, 4, 7, 10, 11, 7, 12, 6, 7, 16, 18, 19]))
        print(solution.subarraySort(nums: [2, 1]))
        print(solution.subarraySort(nums: [1, 2, 8, 4, 5]))
        
        print("Algo")
        print(solution.subarraySortAlgo(nums: [1, 2, 4, 7, 10, 11, 7, 12, 6, 7, 16, 18, 19]))
        print(solution.subarraySortAlgo(nums: [2, 1]))
        print(solution.subarraySortAlgo(nums: [1, 2, 8, 4, 5]))
    }
    
    // https://www.algoexpert.io/questions/Subarray%20Sort
    private class SolutionArrayIteration {
        func subarraySort(nums: [Int]) -> [Int] {
            var i: Int = 0
            var j: Int = 1
            var maxVal = Int.min
            var lastIndexOfViolation = Int.max
            var minViolation = Int.max
            
            // Time: O(N)
            while i < nums.count-1 {
                // Keep a running max of the entire array.
                maxVal = max(maxVal, nums[i])
                // If the value is less than the max, it's violated this array.
                if nums[j] < maxVal {
                    // Keep track of the last index of the violation.
                    lastIndexOfViolation = j
                    // Also keep track of the lowest number that's violated this index.
                    minViolation = min(minViolation, nums[j])
                }
                j += 1
                i += 1
            }
            
            // Time: O(N)
            if lastIndexOfViolation != Int.max {
                for (i, val) in nums.enumerated() {
                    if minViolation < val {
                        return [i, lastIndexOfViolation]
                    }
                }
            }
            
            return [-1, -1]
        }
        
        
        func subarraySortAlgo(nums: [Int]) -> [Int] {
            var minOutOfOrder = Int.max
            var maxOutOfOrder = Int.min
            
            for i in nums.indices {
                if isOutOfOrder(i, nums: nums) {
                    minOutOfOrder = min(minOutOfOrder, nums[i])
                    maxOutOfOrder = max(maxOutOfOrder, nums[i])
                }
            }
            
            if minOutOfOrder == Int.max {
                return [-1, -1]
            }
            
            var minOutOfOrderIndex = 0
            while minOutOfOrder >= nums[minOutOfOrderIndex] {
                minOutOfOrderIndex += 1
            }
            var maxOutOfOrderIndex = nums.count - 1
            while maxOutOfOrder <= nums[maxOutOfOrderIndex] {
                maxOutOfOrderIndex -= 1
            }
            return [minOutOfOrderIndex, maxOutOfOrderIndex]
        }
        
        private func isOutOfOrder(_ i: Int, nums: [Int]) -> Bool {
            let val = nums[i]
            
            if i == 0 {
                return val > nums[i + 1]
            }
            else if i == nums.count - 1 {
                return val < nums[i - 1]
            }
            return val < nums[i - 1] || val > nums[i + 1]
        }
    }
}
