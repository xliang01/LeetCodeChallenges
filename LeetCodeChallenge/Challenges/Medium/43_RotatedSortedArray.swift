//
//  43_RotatedSortedArray.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 5/15/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class RotatedSortedArray: Runnable {
    func runTests() {
        let solution1 = SolutionRecursion()
        print(solution1.search([1,3], 2))
        print(solution1.search([4,5,6,7,0,1,2], 0))
        print(solution1.search([4,5,6,7,0,1,2], 3))
    }
    
    private class SolutionRecursion {
        func search(_ nums: [Int], _ target: Int) -> Int {
            guard !nums.isEmpty else { return -1 }
            return search(nums, target, 0, nums.count - 1)
        }
        
        func search(_ nums: [Int], _ target: Int, _ start: Int, _ end: Int) -> Int {
            if start >= end {
                return nums[start] == target ? start : -1
            }
            
            let mid = (start + end) / 2
            if nums[mid] == target { return mid }
            if start == mid && mid == nums.count - 1 { return -1 }
            
            if start != mid && !checkShift(nums, start, mid - 1) && target >= nums[start] && target <= nums[mid - 1] {
                return search(nums, target, start, mid - 1)
            }
            else if mid != nums.count - 1 && !checkShift(nums, mid + 1, end) && target >= nums[mid + 1] && target <= nums[end] {
                return search(nums, target, mid + 1, end)
            }
            else if start != mid && checkShift(nums, start, mid - 1) && (target >= nums[start] || target <= nums[end]) {
                return search(nums, target, start, mid - 1)
            }
            else if mid != nums.count - 1 && checkShift(nums, mid + 1, end) && (target >= nums[mid + 1] || target <= nums[end]) {
                return search(nums, target, mid + 1, end)
            }
            return -1
        }
        
        func checkShift(_ nums: [Int], _ start: Int, _ end: Int) -> Bool {
            return nums[start] > nums[end]
        }
    }
}
