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
        let solution = SolutionRecursive()
//        var nums = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
        var nums = [9, 4, 6, 1, 2, 3, 8]
        solution.sort(&nums, 0, nums.count-1)
        print(nums)
    }
    
    private class SolutionRecursive {
        func sort(_ nums: inout [Int], _ start: Int, _ end: Int) {
            if start >= end {
                return
            }
            
            let p = partitionHigh(&nums, start, end)
            sort(&nums, start, p-1)
            sort(&nums, p+1, end)
        }
        
        // [1, 4, 3, 6, 8]
        //           i
        //              j
        private func partitionHigh(_ nums: inout [Int], _ start: Int, _ end: Int) -> Int {
            if start >= end {
                return start
            }
            
            var i = start
            let pivot = nums[end]
            
            for j in i..<end {
                if nums[j] <= pivot {
                    swap(&nums, i, j)
                    i += 1
                }
            }
            swap(&nums, i, end)
            return i
        }
        
        private func partitionLow(_ nums: inout [Int], _ start: Int, _ end: Int) -> Int {
            if start >= end {
                return start
            }
            
            var i = start + 1
            let pivot = nums[start]
            
            for j in i...end {
                if nums[j] < pivot {
                    swap(&nums, i, j)
                    i += 1
                }
            }
            swap(&nums, i-1, start)
            return i-1
        }
        
        private func swap(_ nums: inout [Int], _ start: Int, _ end: Int) {
            let temp = nums[start]
            nums[start] = nums[end]
            nums[end] = temp
        }
    }
}
