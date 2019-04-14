//
//  26_MaxSubArray.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 4/11/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class MaxSubArray : Runnable {
    func runTests() {
        let solution1 = SolutionBruteForce()
//        print(solution1.maxSubArray([1,-2,3,0]))
//        print(solution1.maxSubArray([-2,1,-3,4,-1,2,1,-5,4]))
    
        let solution2 = SolutionIterative()
//        print(solution2.maxSubArray([1,-2,3,0]))
//        print(solution2.maxSubArray([-2,1,-3,4,-1,2,1,-5,4]))
        print(solution2.maxSubArray([-1,-2,-3,0]))
    }
    
    private class SolutionBruteForce {
        func maxSubArray(_ nums: [Int]) -> Int {
            var max = nums.first!
            for i in (0..<nums.count) {
                var sum: Int = 0
                for j in (i..<nums.count) {
                    sum += nums[j]
                    if sum > max {
                        max = sum
                    }
                }
            }
            
            return max
        }
    }
    
    private class SolutionIterative {
        /**
            Solution:
         
                If the new max for the contiguous number is greater than the last max, take the new max as the current index. Otherwise,
                take the max from the current number + previous max.
         
            Performance:
         
                Time Complexity: O(N)
                Space Complexity: O(1)
         */
        func maxSubArray(_ nums: [Int]) -> Int {
            var subMax = nums.first!
            var maxValue = nums.first!
            var startIndex = 0
            var previousIndex = 0
            var endIndex = 0
//            Example: -2,1,-3,4,-1,2,1,-5,4
//              -2  sm = -2, m = -2
//               1  sm =  1, m = 1
//              -3  sm = -2, m = 1
//               4  sm =  4, m = 4
//              -1  sm =  3, m = 4
//               2  sm =  5, m = 5
//               1  sm =  6, m = 6
//              -5  sm =  1, m = 6
//               4  sm =  5, m = 6
            
//            Example: -1,-2,-3,0
//              -1  sm = -1, m = -1
//              -2  sm = -2, m = -1
//              -3  sm = -3, m = -1
//               0  sm =  0, m =  0
            for i in (1..<nums.count) {
                subMax = max(nums[i], nums[i] + subMax)
                maxValue = max(subMax, maxValue)
                
                if subMax < 0 {
                    startIndex = i + 1
                }
                else if subMax == maxValue {
                    previousIndex = startIndex
                    endIndex = i
                }
            }
//            print (previousIndex, endIndex)
            return maxValue
        }
    }
    
    private class SolutionRecursiveSubsets {
        private var maxValue: Int!
        
        func maxSubArray(_ nums: [Int]) -> Int {
            sum(nums, 0, [])
            return maxValue
        }
        
        func sum(_ nums: [Int], _ index: Int, _ combo: [Int]) {
            if index == nums.count {
                return
            }
            var combo = combo
        
            for i in (index..<nums.count) {
                combo.append(nums[i])
                print(combo: combo)
                assignMax(combo: combo, maxSize: nums.count - 1)
                sum(nums, i+1, combo)
                _ = combo.popLast()
            }
        }
        
        func assignMax(combo: [Int], maxSize: Int) {
            guard combo.count < maxSize else {
                return
            }
            
            let comboSum: Int = combo.reduce(0, { x, y in x + y } )
            if maxValue == nil {
                maxValue = comboSum
            }
            else if maxValue < comboSum {
                maxValue = comboSum
            }
        }
        
        func print(combo: [Int]) {
            let comboString = combo.map { String($0) }.joined(separator: ",")
            Swift.print(comboString)
        }
    }
}
