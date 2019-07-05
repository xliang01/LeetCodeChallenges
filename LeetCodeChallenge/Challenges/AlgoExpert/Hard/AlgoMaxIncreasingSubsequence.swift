//
//  AlgoMaxIncreasingSubsequence.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/4/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class AlgoMaxIncreasingSubsequence: Runnable {
    func runTests() {
        let solution = SolutionDP()
        print(solution.maxIncreasingSubsequence([10, 70, 20, 30, 50, 11, 30]))
        print(solution.maxIncreasingSubsequence([-1]))
        print(solution.maxIncreasingSubsequence([1, 2, 3, 4, 5]))
    }
    
    private class SolutionDP {
        func maxIncreasingSubsequence(_ nums: [Int]) -> (Int, [Int]) {
            if nums.count == 1 { return (nums[0], nums) }
            var maxNums = [Int]()
            var dp = [Int](repeating: 0, count: nums.count)
            
            dp[0] = nums[0]
            maxNums.append(nums[0])
            
            for i in 1..<nums.count {
                var tempMax = nums[i]
                var tempNums = [Int]()
                
                for j in 0..<i {
                    if nums[j] < nums[i] {
                        tempMax += nums[j]
                        tempNums.append(nums[j])
                    }
                }
                tempNums.append(nums[i])
                
                if tempMax > dp[i-1] {
                    dp[i] = tempMax
                    maxNums = tempNums
                }
                else {
                    dp[i] = dp[i-1]
                }
            }
            
            return (dp[nums.count-1], maxNums)
        }
    }
}
