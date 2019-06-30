//
//  RemoveDuplicates.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/23/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class RemoveDuplicates: Runnable {
    func runTests() {
        let solution = SolutionHash()
        var array = [1, 1, 2]
        let len = solution.removeDuplicates(&array)
        print(len)
        
        for i in 0..<len {
            print(array[i])
        }
    }
    
    private class SolutionHash {
        func removeDuplicates(_ nums: inout [Int]) -> Int {
            // 1, 2, 3
            if nums.count == 1 { return 1 }
            var set = Set<Int>()
            var i = 0
            var j = 0
            
            while j < nums.count {
                if !set.contains(nums[j]) {
                    set.insert(nums[j])
                    nums[i] = nums[j]
                    i += 1
                }
                j += 1
            }
            
            return i
        }
    }
}
