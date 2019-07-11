//
//  ArrayJump.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/9/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class ArrayJump: Runnable {
    func runTests() {
        let solution = SolutionDP()
        print(solution.canJump([2,3,1,1,4]))
        print(solution.canJump([3,2,1,0,4]))
        print(solution.canJump([2,0]))
        print(solution.canJump([1,0,4]))
    }
    
    // T: O(N^2)
    // S: O(N)
    private class SolutionDP {
        func canJump(_ nums: [Int]) -> Bool {
            if nums.count == 1 { return true }
            var dp = [Bool](repeating: false, count: nums.count)
            dp[nums.count - 1] = true
            
            for j in stride(from: nums.count - 2, through: 0, by: -1) {
                let largestJump = min(nums[j] + j, nums.count - 1)
                
                for nextJump in j...largestJump {
                    if dp[nextJump] == true {
                        dp[j] = true
                    }
                }
            }
            return dp[0]
        }
    }
    
    private class SolutionRecursionMemo {
        func canJump(_ nums: [Int]) -> Bool {
            var memo = [Bool?](repeating: nil,
                               count: nums.count)
            if canJump(nums, 0, &memo) { return true }
            return false
        }
        
        private func canJump(_ nums: [Int],
                               _ jumpIndex: Int,
                               _ memo: inout [Bool?]) -> Bool {
            if jumpIndex == nums.count - 1 { return true }
            if let jumpStatus = memo[jumpIndex] { return jumpStatus }
            
            let farthestJump = min(jumpIndex + nums[jumpIndex], nums.count - 1)
            var nextJump = jumpIndex + 1
            
            while nextJump <= farthestJump {
                if canJump(nums, nextJump, &memo) {
                    memo[jumpIndex] = true
                    return true
                }
                nextJump += 1
            }
            
            memo[jumpIndex] = false
            return false
        }
    }
    
    // T: O(2^n), where J is the max length of each jump
    // S: O(N)
    private class SolutionRecursion {
        func canJump(_ nums: [Int]) -> Bool {
            if canJump(nums, 0) { return true }
            return false
        }
        
        private func canJump(_ nums: [Int],
                             _ jumpIndex: Int) -> Bool {
            if jumpIndex == nums.count - 1 { return true }
            else if jumpIndex > nums.count { return false }
            
            let maxJumps = nums[jumpIndex]
            var currentJumpIndex = 1
            while currentJumpIndex <= maxJumps {
                if canJump(nums, currentJumpIndex + jumpIndex) { return true }
                currentJumpIndex += 1
            }
            return false
        }
    }
}
