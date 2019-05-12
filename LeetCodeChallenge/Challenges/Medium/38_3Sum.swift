//
//  38_3Sum.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 5/7/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class ThreeSum: Runnable {
    func runTests() {
        let solution1 = SolutionHashMap()
        print(solution1.threeSum([-1,0,1,2,-1,-4]))
        print(solution1.threeSum([-4,-2,-2,-2,0,1,2,2,2,3,3,4,4,6,6]))
        print(solution1.threeSum([0, 0, 0, 0, 0, 0]))
        print(solution1.threeSum([]))
        
        let solution2 = SolutionShrinkingWindow()
        print(solution2.threeSum([-1,0,1,2,-1,-4]))
        print(solution2.threeSum([-4,-2,-2,-2,0,1,2,2,2,3,3,4,4,6,6]))
        print(solution2.threeSum([0, 0, 0, 0, 0, 0]))
        print(solution2.threeSum([]))
    }
    
//    var result = [[Int]]()
//    var start = 0
//    var end = 0
//    var sum = 0
//
//    for i in 0..<(nums.count - 2) {
//    if i == 0 || (i > 0 && nums[i] != nums[i - 1]) {
//    start = i + 1
//    end = nums.count - 1
//    sum = 0 - nums[i]
//    while start < end {
//    if nums[start] + nums[end] == sum {
//    result.append([nums[i], nums[start], nums[end]])
//    while start < end && nums[start] == nums[start + 1] {
//    start += 1
//    }
//    while start < end && nums[end] == nums[end - 1] {
//    end -= 1
//    }
//    start += 1
//    end -= 1
//    } else if nums[start] + nums[end] < sum {
//    start += 1
//    } else {
//    end -= 1
//    }
//    }
//    }
//    }
//
//    return result
    
    class SolutionShrinkingWindow {
        /**
            Solution:
         
            For every number in the array, check if the number at k + i + j is 0. Then shrink the window between i and j.
            If there are duplicate numbers, keep shrinking the window until there are no more duplicates. Check if the
            sums are 0. Then keep shrinking the window until i == j. When this happens, go to the next item in k and repeat
            the process. If the item at k is the same as k-1, skip. This is because if the number at k is the same as k-1,
            then the combinations for the entire previous k has already been checked.
         */
        func threeSum(_ nums: [Int]) -> [[Int]] {
            guard nums.count > 2 else { return [[Int]]() }
            var answers = [[Int]]()
            let nums = nums.sorted()
            let n = nums.count
            
            for k in (0..<n) {
                var i = k + 1
                var j = n - 1
                
                if k > 0 && nums[k] == nums[k - 1] { continue }
                while i < j {
                    if nums[k] + nums[i] + nums[j] == 0 {
                        answers.append([nums[k], nums[i], nums[j]])
                        while i < j && nums[i] == nums[i + 1] { i += 1 }
                        while i < j && nums[j] == nums[j - 1] { j -= 1 }
                        i += 1
                        j -= 1
                    }
                    else if nums[k] + nums[i] + nums[j] < 0 {
                        i += 1
                    }
                    else if nums[k] + nums[i] + nums[j] > 0 {
                        j -= 1
                    }
                }
            }
            return answers
        }
    }
    
    class SolutionHashMap {
        func threeSum(_ nums: [Int]) -> [[Int]] {
            guard nums.count > 2 else { return [[Int]]() }
            
            var answers = [[Int]]()
            let nums = nums.sorted()
            var comboCache = Set<String>()
            
            for i in (0..<nums.count-2) {
                let sourceNum = nums[i]
                let complement1 = 0 - sourceNum
                var previousNumbers = Set<Int>()
                
                for j in (i+1..<nums.count) {
                    let complement2 = complement1 - nums[j]
                    if previousNumbers.contains(complement2) {
                        let key = "\(sourceNum)-\(complement2)-\(nums[j])"
                        if !comboCache.contains(key) {
                            answers.append([sourceNum, complement2, nums[j]])
                            comboCache.insert(key)
                        }
                    }
                    else {
                        previousNumbers.insert(nums[j])
                    }
                }
            }
            return answers
        }
    }
}
