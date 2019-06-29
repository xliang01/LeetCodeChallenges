//
//  SquareNumbers.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/28/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class SquareNumbers: Runnable {
    func runTests() {
        
    }
    
    private class SolutionSquare {
        func square(_ nums: [Int]) -> [Int] {
            guard !nums.isEmpty else { return [] }
            
            var k = 0
            for i in 0..<nums.count {
                if nums[i] >= 0 {
                    k = i
                    break
                }
            }
            
            var ans = [Int]()
            var i = k - 1
            var j = k
            
            while i >= 0 && j < nums.count {
                if nums[i] * nums[i] <= nums[j] * nums[j] {
                    ans.append(nums[i] * nums[i])
                    i -= 1
                }
                else {
                    ans.append(nums[j] * nums[j])
                    j += 1
                }
            }
            
            while i >= 0 {
                ans.append(nums[i] * nums[i])
                i -= 1
            }
            
            while j < nums.count {
                ans.append(nums[j] * nums[j])
                j += 1
            }
            
            return ans
        }
    }
}
