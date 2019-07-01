//
//  MinRewards.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/30/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class MinRewards: Runnable {
    func runTests() {
        print("Algo: T: O(N), S: O(N) - Pattern: Peaks and Valleys")
        let solution = SolutionIterationPeaksAndValleys()
        print(solution.minRewards([8, 4, 2, 1, 3, 6, 7, 9, 5]))
        print(solution.minRewards([2, 20, 13, 12, 11, 8, 4, 3, 1, 5, 6, 7, 9, 0]))
    }
    
    // https://www.algoexpert.io/questions/Min%20Rewards
    private class SolutionIterationPeaksAndValleys {
        func minRewards(_ nums: [Int]) -> Int {
            guard nums.count > 1 else { return 1 }
            // Go right and figure out which student gets the reward by looking at students on the left.
            var rewards = [Int](repeating: 1, count: nums.count)
            // Check if the score to the left is less than the score to the right. If it is, then it means we can't
            // have more rewards than the person before. Therefore, don't do anything because we can't really advance.
            
            // First pass just to award students that have more awards than its left student.
            for i in 1..<nums.count {
                // If this student has more rewards than its left student, give it a reward.
                if nums[i] > nums[i - 1] {
                    rewards[i] = max(rewards[i - 1] + 1, rewards[i])
                }
            }
            
            // Second pass, see how students fair to its right student.
            for i in stride(from: nums.count - 2, through: 0, by: -1) {
                // If this student has more rewards than its right student, give it a reward.
                if nums[i] > nums[i + 1] {
                    rewards[i] = max(rewards[i + 1] + 1, rewards[i])
                }
            }
            
            // Sum up everything.
            var sum = 0
            for reward in rewards {
                sum += reward
            }
            return sum
        }
    }
}
