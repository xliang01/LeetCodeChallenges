//
//  49_NextPermutation.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 5/28/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class NextPermutation: Runnable {
    func runTests() {
        let solution1 = SolutionArraySwap()
        
        var nums = [1, 2, 3]
        solution1.nextPermutation(&nums)
        print(nums)

        nums = [3, 2, 1]
        solution1.nextPermutation(&nums)
        print(nums)

        nums = [3, 1, 2]
        solution1.nextPermutation(&nums)
        print(nums)
        
        nums = [1, 5, 1]
        solution1.nextPermutation(&nums)
        print(nums)
    }
    
    // There is a trick to solving this problem: https://leetcode.com/problems/next-permutation/solution/
    /*
        Find the first occurance of a number at index that's smaller than the next number at index + 1.
        Then from that index, find the largest index where it's still larger than the number at index.
        Swap these two numbers when found. This guarantees the next number is the largest next sequence.
        Then reverse the remaining list to get the correct answer.
     */
    private class SolutionArraySwap {
        func nextPermutation(_ nums: inout [Int]) {
            guard nums.count > 1 else { return }
            var foundIndex = -1
            
            for index in (1..<nums.count).reversed() {
                if nums[index] > nums[index-1] {
                    foundIndex = index - 1
                    break
                }
            }
            
            if foundIndex >= 0 {
                var swapIndex = foundIndex + 1
                for index in (swapIndex..<nums.count) {
                    if nums[index] <= nums[foundIndex] { break }
                    swapIndex = index
                }
                swap(&nums, foundIndex, swapIndex)
            }
            
            reverse(&nums, foundIndex + 1, nums.count - 1)
        }
        
        private func swap(_ nums: inout [Int], _ left: Int, _ right: Int) {
            let temp = nums[left]
            nums[left] = nums[right]
            nums[right] = temp
        }
        
        private func reverse(_ nums: inout [Int], _ left: Int, _ right: Int) {
            var left = left
            var right = right
            
            while left < right {
                swap(&nums, left, right)
                left += 1
                right -= 1
            }
        }
    }
}
