//
//  RotateArray.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/23/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class RotateArray: Runnable {
    func runTests() {
        let solution = SolutionRotate()
        var nums = [1,2,3,4,5,6,7]
        solution.rotate(&nums, 1)
        print (nums)
    }
    
    private class SolutionRotate {
        func rotate(_ nums: inout [Int], _ k: Int) {
            if nums.count == 1 { return }
            
            // Solution 1
            // var temp = [Int](repeating: 0, count: nums.count)
            // for (i, val) in nums.enumerated() {
            //     temp[(i + k) % nums.count] = nums[i]
            // }
            // nums = temp
            
            // Solution 2 - Timeout
            //  for _ in 0..<k {
            //     let lastNum = nums[nums.count-1]
            //     for i in stride(from: nums.count-1, to: 0, by: -1) {
            //         let index = abs(i-1) % nums.count
            //         nums[i] = nums[index]
            //     }
            //     nums[0] = lastNum
            // }
            
            // Solution 3
            var k = k
            if k == nums.count { return }
            k = k % nums.count
            reverse(&nums, 0, nums.count-1)
            reverse(&nums, 0, k - 1)
            reverse(&nums, k, nums.count-1)
        }
        
        private func reverse(_ nums: inout [Int], _ start: Int, _ end: Int) {
            if start < 0 || end >= nums.count { return }
            var start = start
            var end = end
            
            while start < end {
                let temp = nums[start]
                nums[start] = nums[end]
                nums[end] = temp
                start += 1
                end -= 1
            }
        }
    }
}
