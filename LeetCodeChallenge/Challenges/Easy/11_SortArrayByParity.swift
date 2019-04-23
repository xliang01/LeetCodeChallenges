//
//  11_SortArrayByParity.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 3/22/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

/**
    Given an array A of non-negative integers, return an array consisting of all the even elements
    of A, followed by all the odd elements of A.
 
    You may return any answer array that satisfies this condition.
 
 
 
    Example 1:
 
    Input: [3,1,2,4]
    Output: [2,4,3,1]
    The outputs [4,2,3,1], [2,4,1,3], and [4,2,1,3] would also be accepted
 */
class SortedArrayByParity: Runnable {
    func runTests() {
        let solution1 = SolutionIndexInsert()
        print(solution1.sortArrayByParity([3,1,2,4]))
        
        let solution2 = SolutionIndexSwap()
        print(solution2.sortArrayByParity([3,1,2,4]))
        print(solution2.sortArrayByParity([1,3,5,7]))
        print(solution2.sortArrayByParity([2,4,6,8]))
    }
    
    private class SolutionIndexInsert {
        func sortArrayByParity(_ A: [Int]) -> [Int] {
            var sortedArray = [Int](repeating: 0, count: A.count)
            var left = 0
            var right = A.count - 1
            
            A.forEach { value in
                // If odd
                if (value & 1) == 1 {
                    sortedArray[right] = value
                    right -= 1
                }
                // If even
                else {
                    sortedArray[left] = value
                    left += 1
                }
            }
            
            return sortedArray
        }
    }
    
    private class SolutionIndexSwap {
        /**
            Solution:
         
            While using the same array, swap the odd numbers for even numbers as two indices are
            converging toward the center.
         
            Performance:
         
            Runtime Complexity: O(N) because we have to still iterate through the array once.
            Space Complexity: O(1) because we don't have to create any more data structures.
         */
        func sortArrayByParity(_ A: [Int]) -> [Int] {
            guard !A.isEmpty else {
                return []
            }
            
            var array = A
            var left = 0
            var right = A.count - 1
            
            // [1357]
            // [2468]
            /*
                [1241]              left = 0, right = 2
                    -> [4211]       left = 1, right = 1
             
            */
            // [1241]
            while(left < right && right > left) {
                // Keep iterating because I'm even
                while(array[left] & 1 == 0 && left < right) {
                    left += 1
                }
                // Keep iterating because I'm odd
                while(array[right] & 1 == 1 && right > left) {
                    right -= 1
                }
                
                if left != right {
                    let temp = array[left]
                    array[left] = array[right]
                    array[right] = temp
                    left += 1
                    right -= 1
                }
            }
            
            return array
        }
    }
}
