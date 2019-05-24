//
//  46_SubarraySumK.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 5/22/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class SubarraySumK: Runnable {
    func runTests() {
        let solution1 = SolutionIterative()
        print(solution1.subarraySum([1,1,1], 2))
    }
    
    private class SolutionIterative {
        func subarraySum(_ nums: [Int], _ k: Int) -> Int {
            var count = 0
            
            for i in 0..<nums.count {
                var sum = 0
                for j in i..<nums.count {
                    sum += nums[j]
                    if sum == k {
                        count += 1
                    }
                }
            }
            
            return count
        }
    }
}
