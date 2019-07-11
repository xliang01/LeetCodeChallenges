//
//  KthPermutationOfANumber.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/10/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class KthPermutationOfANumber: Runnable {
    func runTests() {
        let solution = SolutionBackTracking()
        print(solution.getPermutation(3, 5))
    }
    
    private class SolutionBackTracking {
        func getPermutation(_ n: Int, _ k: Int) -> String {
            var nums: [Int] = []
            for i in 1...n {
                nums.append(i)
            }
            var result: String = ""
            backtracking(&nums, n, k, factorial(n - 1), &result)
            return result
        }
        
        func backtracking(_ nums: inout [Int], _ n: Int, _ k: Int, _ count: Int, _ result: inout String) {
            if nums.count == 1 {
                result += String(nums[0])
                return
            }
            
            var index = k / count
            var nextIndex = k % count
            
            if nextIndex == 0 {
                index -= 1
                nextIndex = count
            }
            
            result += String(nums.remove(at: index))
            backtracking(&nums, n - 1, nextIndex, count / (n - 1), &result)
        }
        
        func factorial(_ n: Int) -> Int {
            var n = n
            var result = 1
            while n > 1 {
                result *= n
                n -= 1
            }
            return result
        }
    }
    
    private class SolutionIterative {
        func getPermutation(_ n: Int,
                            _ k: Int) -> String {
            if n <= 1 { return "\(n)" }
            var nums = [Int](repeating: 0, count: n)
            for i in 1...n { nums[i - 1] = i }
            
            var j = 0
            while j < k-1 {
                getNextPermutation(&nums)
                j += 1
            }
            return nums.map { "\($0)" }.joined()
        }
        
        func getNextPermutation(_ nums: inout [Int]) {
            var indexOfDecreasingNumber = nums.count - 1
            for i in stride(from: nums.count - 1, to: 0, by: -1) {
                // Find the first occurence where i is greater.
                if nums[i] > nums[i - 1] {
                    indexOfDecreasingNumber = i - 1
                    break
                }
            }
            
            var j = indexOfDecreasingNumber + 1
            var indexToSwap = j
            while j < nums.count {
                if nums[j] <= nums[indexOfDecreasingNumber] { break }
                indexToSwap = j
                j += 1
            }
            
            swap(&nums, indexOfDecreasingNumber, indexToSwap)
            reverse(&nums, indexOfDecreasingNumber+1, nums.count-1)
            return
        }
        
        func swap(_ nums: inout [Int],
                  _ i: Int,
                  _ j: Int) {
            let temp = nums[i]
            nums[i] = nums[j]
            nums[j] = temp
        }
        
        func reverse(_ nums: inout [Int],
                     _ i: Int,
                     _ j: Int) {
            var i = i
            var j = j
            while i < j {
                swap(&nums, i, j)
                i += 1
                j -= 1
            }
        }
    }
}
