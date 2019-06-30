//
//  RemoveElement.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/28/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class RemoveElement: Runnable {
    func runTests() {
        let solution = SolutionPointer()
        var nums = [1, 2, 3, 4, 5, 6, 6, 7, 8]
        print(solution.removeElement(&nums, 4))
    }
    
    private class SolutionPointer {
        func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
            var j = 0
            for i in 0..<nums.count {
                if nums[i] != val {
                    nums[j] = nums[i]
                    j += 1
                }
            }
            return j
        }
    }
}
