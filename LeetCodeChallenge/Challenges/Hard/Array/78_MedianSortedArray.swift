//
//  78_MedianSortedArray.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/14/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class MedianSortedArray: Runnable {
    func runTests() {
        let solution1 = SolutionArrayCopy()
        print(solution1.findMedianSortedArrays([1, 3], [2]))
        print(solution1.findMedianSortedArrays([1, 2], [3, 4]))
        
        let solution2 = SolutionArrayPartition()
        print(solution2.findMedianSortedArrays([1, 3], [2]))
    }
    
    private class SolutionArrayPartition {
        func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        /**
            Ensure the top array is always smaller than the bottom array to partition correctly.
            https://www.geeksforgeeks.org/median-two-sorted-arrays-different-sizes-ologminn-m/
         
            Array = [1 2 3 4 5 (6 7) 8 9 10 11 12] - Even -> Needs to create average.
            Median = 6 + 7 / 2 = 6.5
         
            [1 3 5 7 9]    M = 5
            [2 4 6 8 10 12]  N = 6
         
            start = 0, end = 5
            Partition X = (start + end) / 2
            Partition X + Partition Y = (M + N + 1) / 2
         
            [1 3 5 | 7 9]
            Partition X = (0 + 5) / 2 = 2
            
            [2 4 6 8 10 | 12]
            Partition Y = (5 + 6 + 1) / 2 - Partition X = 6 - Partition X = 6 - 2 = 4
         
            Partition 1 = (0 + 5) / 2 -> 2
            Partition 2 = (5 + 6 + 1) / 2 -> 12 / 2 -> 6
         
            With partion X, ensure the LEFT max X is greater than the RIGHT min Y
            With partion Y, ensure the LEFT min of Y is less than the RIGHT min X.
             
            This gaurantees that a partition is found
        */
            let x = nums1.count
            let y = nums2.count
            if x > y {
                return findMedianSortedArrays(nums2, nums1)
            }
            
            var low = 0
            var high = x
            
            while low <= high {
                let partitionX = (low + high) / 2
                let partitionY = (x + y + 1) / 2 - partitionX
                
                let maxLeftX = partitionX == 0 ? Int.min : nums1[partitionX - 1]
                let minRightX = partitionX == x ? Int.max : nums1[partitionX]
                
                let maxLeftY = partitionY == 0 ? Int.min : nums2[partitionY - 1]
                let minRightY = partitionY == y ? Int.max : nums2[partitionY]
                
                if maxLeftX > minRightY {
                    high = partitionX - 1
                }
                else if maxLeftY > minRightX {
                    low = partitionX + 1
                }
                else {
                    // If odd.
                    if (x + y) % 2 != 0 {
                        return Double(max(maxLeftY, maxLeftX))
                    }
                    else {
                        return Double(max(maxLeftY, maxLeftX) + min(minRightX, minRightY)) / 2.0
                    }
                }
            }
            
            print("Error because array wasn't sorted.")
            return 0
        }
    }
    
    /**
        Solution:
     
        Create a total array using O(N) and find the median.
     
        Performance:
     
        Time Complexity: O(N) for looping N times.
        Space Complexity: O(N) for creating the array.
     */
    private class SolutionArrayCopy {
        func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
            var answer = [Int]()
            var p1 = 0
            var p2 = 0
            
            // Fill to the max of p1 and p2.
            while p1 < nums1.count && p2 < nums2.count {
                if nums1[p1] < nums2[p2] {
                    answer.append(nums1[p1])
                    p1 += 1
                }
                else {
                    answer.append(nums2[p2])
                    p2 += 1
                }
            }
            
            // Fill remaining p1
            while p1 < nums1.count {
                answer.append(nums1[p1])
                p1 += 1
            }
            
            // Fill remaining p2
            while p2 < nums2.count {
                answer.append(nums2[p2])
                p2 += 1
            }
            //1 2 3
            // 1 2 3 4 5 6 7 8 9 10 | N = 10 | Pivot = 10/2-1, 10/2-2
            // 1 2 3 4 5 6 7 8 9
            // 1 2 3
            // 1 2 3 4 p1 = 4 + 1 / 2 = 2
            if answer.count % 2 == 0 {
                let pivot = (answer.count + 1) / 2
                return Double(answer[pivot] + answer[pivot-1]) / 2.0
            }
            else {
                return Double(answer[answer.count / 2])
            }
        }
    }
}
