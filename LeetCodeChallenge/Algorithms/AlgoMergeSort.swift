//
//  MergeSort.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/2/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class AlgoMergeSort: Runnable {
    func runTests() {
        let solution = AlgoMergeSort.MergeSort()
        print(solution.sort([3, 2, 1, 0]))
    }
    
    private class MergeSort {
        func sort(_ nums: [Int]) -> [Int] {
            var nums = nums
            merge(&nums, 0, nums.count-1)
            return nums
        }
        
        private func merge(_ nums: inout [Int], _ left: Int, _ right: Int) {
            guard left < right else { return }
            let mid = (left + right) / 2
            
            // Merge the first half
            merge(&nums, left, mid)
            // Merge the second half
            merge(&nums, mid + 1, right)
            // Sort them combined
            sort(&nums, left, mid, right)
        }
        
        private func sort(_ nums: inout [Int], _ left: Int, _ mid: Int, _ right: Int) {
            guard left < right else { return }
            // Includes mid point
            var leftArray = [Int](repeating: 0, count: mid - left + 1)
            // Excludes mid point
            var rightArray = [Int](repeating: 0, count: right - mid)
            // Get let array items.
            for i in 0..<leftArray.count { leftArray[i] = nums[left + i] }
            // Get right array items.
            for j in 0..<rightArray.count { rightArray[j] = nums[mid + 1 + j] }
            
            var leftPtr = 0
            var rightPtr = 0
            var arrayPointer = left
            
            while leftPtr < leftArray.count && rightPtr < rightArray.count {
                if leftArray[leftPtr] <= rightArray[rightPtr] {
                    nums[arrayPointer] = leftArray[leftPtr]
                    leftPtr += 1
                }
                else {
                    nums[arrayPointer] = rightArray[rightPtr]
                    rightPtr += 1
                }
                
                arrayPointer += 1
            }
            
            while leftPtr < leftArray.count {
                nums[arrayPointer] = leftArray[leftPtr]
                arrayPointer += 1
                leftPtr += 1
            }
            
            while rightPtr < rightArray.count {
                nums[arrayPointer] = rightArray[rightPtr]
                arrayPointer += 1
                rightPtr += 1
            }
        }
        
    }
}
