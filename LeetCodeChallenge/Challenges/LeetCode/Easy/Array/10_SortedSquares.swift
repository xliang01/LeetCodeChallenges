//
//  10_SortedSquares.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 3/22/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

/**
    Given an array of integers A sorted in non-decreasing order, return an array of the squares of
    each number, also in sorted non-decreasing order.
 
    Example 1:

    Input: [-4,-1,0,3,10]
    Output: [0,1,9,16,100]
 
    Example 2:

    Input: [-7,-3,2,3,11]
    Output: [4,9,9,49,121]
 */
class SortedSquares: Runnable {
    func runTests() {
        let solution1 = SolutionIteration()
        print(solution1.sortedSquares([-4,-1,0,3,10]))
        
        let solution2 = SolutionSquare()
        print(solution2.sortedSquares([-4,-1,0,3,10]))
        
        let solution3 = SolutionSplitSearch()
        print(solution3.sortedSquares([-4,-1,0,3,10]))
    }
    
    private class SolutionIteration {
        func sortedSquares(_ A: [Int]) -> [Int] {
            let squared = A.map { $0 * $0 }
            return squared.sorted()
        }
    }
    
    private class SolutionSquare {
        func sortedSquares(_ A: [Int]) -> [Int] {
            let squared = A.map { square($0) }
            return squared.sorted()
        }
        
        private func square(_ n: Int) -> Int {
            if n == 0 {
                return 0
            }
            
            var n = n
            if n < 0 {
                n = -n
            }
            
            let x = n >> 1
            // If odd
            if (n & 1) == 1 {
                return square(x) << 2 + x << 2 + 1
            }
            // If even
            else {
                return square(x) << 2
            }
        }
    }
    
    /**
        Solution:
     
        Use two indices to navigate between positive and negative numbers. As we traverse to the left
        and to the right indices, we pick the squared number that is less than the other number for
        each index.
     
        If the array has no negative or positive numbers, we just traverse the array in the descending
        or ascending order, and square the value.
     
        Performance:
     
        Time Complexity: O(N) because we still have to search through the entire list.
        Space Complexity: O(N) because we still have to create the array of N size.
     */
    
    private class SolutionSplitSearch {
        func sortedSquares(_ A: [Int]) -> [Int] {
            var right = 0
            
            for index in A.indices {
                if A[index] < 0 {
                    right += 1
                }
            }
            var left = right - 1
            var sortedArray = [Int]()
            
            // Cover cases where there is a mix of negative and positive numbers.
            
            while (left >= 0 && right < A.count) {
                let leftSquared = A[left] * A[left]
                let rightSquared = A[right] * A[right]
                
                if leftSquared < rightSquared {
                    sortedArray.append(leftSquared)
                    left -= 1
                }
                else {
                    sortedArray.append(rightSquared)
                    right += 1
                }
            }
            
            // Cover cases where we do not have any positive numbers
            while (left >= 0) {
                sortedArray.append(A[left] * A[left])
                left -= 1
            }
            
            // Cover cases where we do not have any negative numbers
            while (right < A.count) {
                sortedArray.append(A[right] * A[right])
                right += 1
            }
            
            return sortedArray
        }
    }
}
