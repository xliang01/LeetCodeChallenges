//
//  HouseRobber.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/12/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class HouseRobber: Runnable {
    func runTests() {
        let solution = Solution()
//        print(solution.rob([1]))
//        print(solution.rob([2, 3]))
        print(solution.rob([1, 2, 3, 1]))
        print(solution.rob([2, 7, 9, 3, 1]))
    }
    
    private class Solution {
        func rob(_ nums: [Int]) -> Int {
            if nums.count == 0 { return 0 }
            else if nums.count == 1 { return nums[0] }
            else if nums.count == 2 { return max(nums[0], nums[1]) }
            
            var dp = [Int](repeating: 0, count: nums.count)
            dp[0] = nums[0]
            dp[1] = max(nums[0], nums[1])

            for i in 2..<nums.count {
                dp[i] = max(dp[i - 2] + nums[i], dp[i - 1])
            }

            return dp[nums.count - 1]
            
//            var currMax = 0
//            var prevMax = 0
//
//            for i in 0..<nums.count {
//                let num = nums[i]
//                let temp = currMax
//                currMax = max(prevMax + num, currMax)
//                prevMax = temp
//            }
//
//            return currMax
        }
    }
}
