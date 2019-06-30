//
//  Max3Product.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/21/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class Max3Product: Runnable {
    func runTests() {
        let solution1 = SolutionSort()
        print(solution1.maximumProduct([1, 2, 3, 4]))
        
        let solution2 = SolutionVariables()
        print(solution2.maximumProduct([1, 2, 3, 4]))
    }
    
    private class SolutionSort {
        func maximumProduct(_ nums: [Int]) -> Int {
            var nums = nums.sorted()
            let size = nums.count - 1
            return max(nums[size] * nums[size - 1] * nums[size - 2], nums[0] * nums[1] * nums[size - 1])
        }
    }
    
    private class SolutionVariables {
        func maximumProduct(_ nums: [Int]) -> Int {
            if nums.count == 3 { return nums[0] * nums[1] * nums[2] }
            var min1 = Int.max
            var min2 = Int.max
            var max1 = Int.min
            var max2 = Int.min
            var max3 = Int.min
            
            for num in nums {
                if num > max1 {
                    max3 = max2
                    max2 = max1
                    max1 = num
                }
                else if num > max2 {
                    max3 = max2
                    max2 = num
                }
                else if num > max3 {
                    max3 = num
                }
                
                if num < min1 {
                    min2 = min1
                    min1 = num
                }
                else if num < min2 {
                    min2 = num
                }
            }
            
            return max(min1 * min2 * max1, max1 * max2 * max3)
        }
    }
}
