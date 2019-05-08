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
        let solution = SolutionHashMap()
        print(solution.threeSum([-1, 0, 1, 2, -1, 4]))
        print(solution.threeSum([0, 0, 0]))
        print(solution.threeSum([]))
    }
    
    class SolutionPointers {
        
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
