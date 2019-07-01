//
//  LargestRange.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/30/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class AlgoLargestRange: Runnable {
    func runTests() {
        print("Mine: T: O(N*Log(N)), S: O(1)")
        let solution = SolutionIterationSort()
        print(solution.largestRange([1, 11, 3, 0, 15, 5, 2, 4, 10, 7, 12, 6]))
        print(solution.largestRange([4, 2, 1, 3]))
        print(solution.largestRange([8, 4, 2, 10, 3, 6, 7, 9, 1]))
        
        print("Algo: T: O(N), S: (N)")
        print(solution.largestRangeAlgo([1, 11, 3, 0, 15, 5, 2, 4, 10, 7, 12, 6]))
        print(solution.largestRangeAlgo([4, 2, 1, 3]))
        print(solution.largestRangeAlgo([8, 4, 2, 10, 3, 6, 7, 9, 1]))
    }
    
    private class SolutionIterationSort {
        func largestRangeAlgo(_ nums: [Int]) -> [Int] {
            // Space is O(N)
            var visited = [Int: Bool]()
            // Space is O(1)
            var answer = [Int](repeating: Int.min, count: 2)
            var length = Int.min
            
            // Mark all visited as false.
            for val in nums {
                visited[val] = false
            }
            
            // Traversal is O(N) in time.
            for val in nums {
                // Skip values that's already been visited. They must have already been calculated in a range.
                if visited[val] == true { continue }
                // If the value exists in the hash.
                visited[val] = true
                var currLength = 0
                
                // Scan and attempt to find all values less than this current value, and mark them as visited.
                var leftVal = val - 1
                var minVal = val
                while(visited[leftVal] != nil) {
                    visited[leftVal] = true
                    currLength += 1
                    minVal = leftVal
                    leftVal -= 1
                }
                
                // Scan and attempt to find all vales greater than this current value, and mark them as visited.
                var rightVal = val + 1
                var maxVal = val
                while(visited[rightVal] != nil) {
                    visited[rightVal] = true
                    currLength += 1
                    maxVal = rightVal
                    rightVal += 1
                }
                
                if currLength > length {
                    length = currLength
                    answer = [minVal, maxVal]
                }
            }
            return answer
        }
        
        func largestRange(_ nums: [Int]) -> [Int] {
            // Base case where 1 item in the array is it's own range.
            if nums.count == 1 { return [nums[0], nums[0]] }
            
            // Time: O(N * Log(N))
            var nums = nums.sorted()
            
            // If none is found, the entire nums is a valid range.
            var answer = [nums[0], nums[nums.count - 1]]
            var startIdx = 0
            var length = Int.min
            var i = 0
            
            while i <= nums.count - 2 {
                // If the number is not a valid range, calculate the length. If it beats the old length, this is the new valid range.
                if !isValidRange(i, nums: nums) {
                    // Calculate the range.
                    let currLenth = i - startIdx
                    // If it beats the old length, assign new length and range.
                    if currLenth > length {
                        answer = [nums[startIdx], nums[i]]
                        i += 1
                        startIdx = i
                        length = currLenth
                    }
                }
                i += 1
            }
            
            // Check last case in case we reach the end of the array and didn't find an invalid range since the last invalid range.
            let currLenth = i - startIdx
            if currLenth > length {
                answer = [nums[startIdx], nums[i]]
            }
            
            return answer
        }
        
        private func isValidRange(_ i: Int, nums: [Int]) -> Bool {
            return nums[i] == nums[i + 1] - 1
        }
    }
}
