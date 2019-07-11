//
//  ArraySearch.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/9/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class SearchInsertPosition: Runnable {
    func runTests() {
        let solution = SolutionBinarySearch()
        print(solution.searchInsert([1,3,5,6], 5))
        print(solution.searchInsert([1,3,5,6], 2))
        print(solution.searchInsert([1,3,5,6], 7))
        print(solution.searchInsert([1,3,5,6], 0))
    }
    
    // Binary Search
    // T: Log(N)
    // S: O(1)
    private class SolutionBinarySearch {
        func searchInsert(_ nums: [Int], _ target: Int) -> Int {
            return binarySearch(nums, 0,
                                nums.count-1,
                                target)
        }
        
        private func binarySearch(_ nums: [Int],
                          _ start: Int,
                          _ end: Int,
                          _ target: Int) -> Int {
            if start > end {
                return start
            }
            
            let mid = (start + end) / 2
            let val = nums[mid]
            
            if val == target {
                return mid
            }
            else if target > val {
                return binarySearch(nums, mid+1, end, target)
            }
            else {
                return binarySearch(nums, start, mid-1, target)
            }
        }
    }
}
