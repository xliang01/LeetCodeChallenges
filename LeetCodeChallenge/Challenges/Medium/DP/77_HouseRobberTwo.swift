//
//  77_HouseRobberTwo.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/13/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class HouseRobberCircle: Runnable {
    func runTests() {
        let solution = Solution()
        print(solution.rob([1]))
        print(solution.rob([2, 3]))
        print(solution.rob([1, 2, 3]))
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
            
            // If house 0 is robbed.
            dp[1] = max(nums[0], nums[1])
            
            for i in 2..<nums.count - 1 {
                dp[i] = max(dp[i - 2] + nums[i], dp[i - 1])
            }
            let maxFirstHouseRobbed = dp[nums.count - 1]
            
            // If house 1 is robbed.
            var maxSecondHouseRobbed = nums[2]
            dp = [Int](repeating: 0, count: nums.count)
            dp[1] = nums[1]
            for i in 2..<nums.count {
                dp[i] = max(dp[i - 2] + nums[i], dp[i - 1])
            }
            maxSecondHouseRobbed = dp[nums.count - 1]
            return max(maxSecondHouseRobbed, maxFirstHouseRobbed)
        }
        
        func rob(_ nums: [Int], _ end: Int, robFirst: Bool = true) -> Int {
            if nums.count == 0 { return 0 }
            else if nums.count == 1 { return nums[0] }
            else if nums.count == 2 { return max(nums[0], nums[1]) }
            
            var dp = [Int](repeating: 0, count: nums.count)
            dp[0] = nums[0]
            
            if robFirst {
                dp[1] = max(nums[0], nums[1])
            }
            else {
                dp[1] = nums[1]
            }
            
            for i in 2...end {
                dp[i] = max(dp[i - 2] + nums[i], dp[i - 1])
            }
            
            return dp[nums.count-1]
        }
    }
}
