//
//  FindDuplicates.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/22/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class FindDuplicates: Runnable {
    func runTests() {
        let solution = SolutionArrayWithIndexNegative()
        print(solution.findDuplicates([4,3,2,7,8,2,3,1]))
    }
    
    private class SolutionArrayWithIndexNegative {
        func findDuplicates(_ nums: [Int]) -> [Int] {
            var nums = nums
            
            var dups = 0
            for n in nums {
                if nums[n-1] < 0 {
                    dups += 1
                    nums.append(n)
                }
                else {
                    nums[n-1] = abs(nums[n-1]) * -1
                }
            }
            nums.removeFirst(nums.count - dups)
            return nums
        }
    }
}
