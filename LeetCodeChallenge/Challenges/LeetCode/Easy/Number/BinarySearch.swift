//
//  BinarySearch.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/28/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class BinarySearch: Runnable {
    func runTests() {
        let solution = SolutionRecursion()
        let nums = [1, 2, 3, 4, 5]
        print(solution.search(nums, 0, nums.count-1, 1))
        print(solution.search(nums, 0, nums.count-1, 3))
        print(solution.search(nums, 0, nums.count-1, 7))
        print(solution.search(nums, 0, nums.count-1, 0))
    }
    
    private class SolutionRecursion {
        func search(_ nums: [Int], _ target: Int) -> Int {
            return search(nums, 0, nums.count - 1, target)
        }
        
        func search(_ nums: [Int], _ start: Int, _ end: Int, _ target: Int) -> Int {
            if end >= start {
                let mid = (start + end) / 2
                if nums[mid] == target { return mid }
                else if target > nums[mid] {
                    return search(nums, mid + 1, end, target)
                }
                else {
                    return search(nums, start, mid - 1, target)
                }
            }
            return -1
        }
    }
}
