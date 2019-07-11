//
//  QuickSort.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/26/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class AlgoQuickSort: Runnable {
    func runTests() {
        let solution = QuickSortRecursive()
//        var nums = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
        let nums = [9, 4, 6, 1, 2, 3, 8]
        print(solution.sort(nums))
    }
    
    private class QuickSortRecursive {
        func sort(_ nums: [Int]) -> [Int] {
            var nums = nums
            sortMid(&nums, 0, nums.count - 1)
            return nums
        }
        
        private func sort(_ nums: inout [Int],
                          _ start: Int,
                          _ end: Int) {
            if start >= end { return }
            let pivot = partitionLow(&nums, start, end)
            sort(&nums, start, pivot - 1)
            sort(&nums, pivot + 1, end)
        }
        
        private func sortMid(_ nums: inout [Int],
                             _ start: Int,
                             _ end: Int) {
            if start >= end { return }
            let pivot = partitionMid(&nums, start, end)
            if start < pivot - 1 {
                sortMid(&nums, start, pivot-1)
            }
            else {
                sortMid(&nums, pivot, end)
            }
        }
        
        private func partitionLow(_ nums: inout [Int],
                                  _ start: Int,
                                  _ end: Int) -> Int {
            if start >= end { return start }
            let pivot = nums[start]
            var i = start+1
            
            for j in i...end {
                // 9  5  2  10  7   4   3
                // 9  5  2  7   4   3   10
                //                      ^
                // 5  4  6  3   9   10  7
                //    4  3  6
                //          ^
                if nums[j] < pivot {
                    swap(&nums, i, j)
                    i += 1
                }
            }
            let pivotIndex = i - 1
            swap(&nums, pivotIndex, start)
            return pivotIndex
        }
        
        private func partitionHigh(_ nums: inout [Int],
                                   _ start: Int,
                                   _ end: Int) -> Int {
            if start >= end { return start }
            let pivot = nums[end]
            var i = start
            
            for j in i...end-1 {
                // 9  5  2  10  7   4   3
                // 2  5  9  10  7   4   3
                //    ^
                if nums[j] < pivot {
                    swap(&nums, i, j)
                    i += 1
                }
            }
            let pivotIndex = i
            swap(&nums, pivotIndex, end)
            return pivotIndex
        }

        private func partitionMid(_ nums: inout [Int],
                                  _ start: Int,
                                  _ end: Int) -> Int {
            let mid = (start + end) / 2
            let pivot = nums[mid]
            var i = start
            var j = end
            
            while i <= j {
                while nums[i] < pivot { i += 1 }
                while nums[j] > pivot { j -= 1 }
                if i <= j {
                    swap(&nums, i, j)
                    i += 1
                    j -= 1
                }
            }
            
            return i
        }
    }

    private static func swap(_ nums: inout [Int], _ i: Int, _ j: Int) {
        let temp = nums[i]
        nums[i] = nums[j]
        nums[j] = temp
    }
}
