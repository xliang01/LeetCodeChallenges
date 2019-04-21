//
//  31_MergeTwoSortedArrays.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 4/17/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class MergeTwoSortedArrays: Runnable {
    func runTests() {
        let solution = SolutionIterativeSimple()
        var nums1 = [-1, 2, 5, 0, 0, 0]
        let nums2 = [1, 2, 3]
        solution.merge(&nums1, 3, nums2, 3)
        print(nums1)
    }
    
    private class SolutionIterative {
        func merge(_ nums1: inout [Int],
                   _ m: Int,
                   _ nums2: [Int],
                   _ n: Int) {
            let count = m + n
            var nums1Index = m - 1
            var nums2Index = n - 1
            
            var currentPointer = count - 1
            while currentPointer >= 0 && nums1Index >= 0 && nums2Index >= 0 {
                let nums1Value = nums1[nums1Index]
                let nums2Value = nums2[nums2Index]

                if nums1Value == nums2Value {
                    nums1[currentPointer] = nums2Value
                    nums1[currentPointer - 1] = nums2Value
                    nums1Index -= 1
                    nums2Index -= 1
                    currentPointer -= 1
                }
                else if nums2Value > nums1Value {
                    nums1[currentPointer] = nums2Value
                    nums2Index -= 1
                }
                else if nums2Value < nums1Value {
                    swap(&nums1, currentPointer, nums1Index)
                    nums1Index -= 1
                }
                currentPointer -= 1
            }
            
            while nums2Index >= 0 {
                nums1[currentPointer] = nums2[nums2Index]
                nums2Index -= 1
                currentPointer -= 1
            }
        }
        
        func swap(_ nums: inout [Int], _ i: Int, _ j: Int) {
            let temp = nums[i]
            nums[i] = nums[j]
            nums[j] = temp
        }
    }
    
    private class SolutionIterativeSimple {
        
        /**
            Starting with a pointer to the right of the array, go left. As the pointer decreases, take which ever number
            is bigger between p1 and p2. Then decrement the pointer of p1 and p2 respectively until all numbers are assigned.
         
            Performance
         
            Time Complexity: O(N) to iterate through the entire array.
            Space Complexity: O(1) since no new data structures are made.
         */
        func merge(_ nums1: inout [Int],
                   _ m: Int,
                   _ nums2: [Int],
                   _ n: Int) {
            var p1 = m - 1
            var p2 = n - 1
            var p = m + n - 1
            
            while p1 >= 0 && p2 >= 0 {
                let value: Int
                if (nums1[p1] < nums2[p2]) {
                    value = nums2[p2]
                    p2 -= 1
                }
                else {
                    value = nums1[p1]
                    p1 -= 1
                }
                nums1[p] = value
                p -= 1
            }
            while p2 >= 0 {
                nums1[p2] = nums2[p2]
                p2 -= 1
            }
        }
    }
}
