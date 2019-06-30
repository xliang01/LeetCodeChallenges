//
//  DisappearingNumbers.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/28/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class DisappearingNumbers: Runnable {
    func runTests() {
        let solution = SolutionArray()
        print(solution.findDisappearedNumbers([4,3,2,7,8,2,3,1]))
    }
    
    private class SolutionArray {
        func findDisappearedNumbers(_ nums: [Int]) -> [Int] {
            var nums = nums
            var res = [Int]()
            for i in nums.indices {
                while nums[i] != i + 1, nums[i] != nums[nums[i] - 1] {
                    nums.swapAt(i, nums[i] - 1)
                }
            }
            for i in nums.indices {
                if nums[i] != i + 1 {
                    res.append(i + 1)
                }
            }
            return res
        }
    }
}
