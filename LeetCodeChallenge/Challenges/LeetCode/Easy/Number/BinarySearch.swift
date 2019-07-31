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
        let solution1 = SolutionRecursion()
        let nums = [1, 2, 3, 4, 5]
        print(solution1.search(nums, 1))
        print(solution1.search(nums, 3))
        print(solution1.search(nums, 7))
        print(solution1.search(nums, 0))
        
        let solution2 = SolutionIterate()
        print(solution2.search(nums, 1))
        print(solution2.search(nums, 3))
        print(solution2.search(nums, 7))
        print(solution2.search(nums, 0))
    }
    
    private class SolutionRecursion {
        func search(_ nums: [Int], _ target: Int) -> Int {
            return search(nums, 0, nums.count - 1, target)
        }
        
        private func search(_ nums: [Int], _ start: Int, _ end: Int, _ target: Int) -> Int {
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
    
    private class SolutionIterate {
        func search(_ nums: [Int], _ target: Int) -> Int {
            var start = 0
            var end = nums.count - 1
            
            while start <= end {
                let mid = (start + end) / 2
                if nums[mid] == target {
                    return mid
                }
                else if target > nums[mid] {
                    start = mid + 1
                }
                else {
                    end = mid - 1
                }
            }
            return -1
        }
    }
}
