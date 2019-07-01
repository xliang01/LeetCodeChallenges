//
//  3SumTarget.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/29/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class AlgoThreeSumTarget: Runnable {
    func runTests() {
        let solution = SolutionWindow()
        print(solution.threeNumbersSum([1, 2, 3], 6))
        print(solution.threeNumbersSum([1, 2, 3], 7))
        print(solution.threeNumbersSum([8, 10, -2, 49, 14], 57))
        print(solution.threeNumbersSum([12, 3, 1, 2, -6, 5, -8, 6], 0))
    }
    
    /**
        Time Complexity: O(N^2)
        Space Complexity: O(N) in case every number is used.
    */
    private class SolutionWindow {
        func threeNumbersSum(_ nums: [Int], _ target: Int) -> [[Int]] {
            if nums.count < 3 { return [] }
            var nums = nums.sorted()
            var answers = [[Int]]()
            
            for i in 0..<nums.count - 2 {
                var j = i + 1
                var k = nums.count - 1
                
                while j < k {
                    let sum = nums[i] + nums[j] + nums[k]
                    if sum == target {
                        answers.append([nums[i], nums[j], nums[k]])
                        j += 1
                        k -= 1
                    }
                    else if sum > target {
                        k -= 1
                    }
                    else if sum < target {
                        j += 1
                    }
                }
            }
            
            return answers
        }
    }
}
