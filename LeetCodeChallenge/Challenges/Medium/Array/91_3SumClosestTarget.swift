//
//  91_ClosestTarget.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/21/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class ThreeSumClosestTarget: Runnable {
    func runTests() {
        let solution = SolutionArray()
        print(solution.threeSumClosest([1,2,4,8,16,32,64,128], 82))
    }
    
    private class SolutionArray {
        func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
            var nums = nums.sorted()
            if nums.count < 3 { return -1 }
            if nums.count == 3 { return nums[0] + nums[1] + nums[2] }
            
            var sumClosesToTarget = nums[0] + nums[1] + nums[nums.count - 1]
            var gap = Int.max
            
            for i in 0..<nums.count - 2 {
                let number = nums[i]
                var j = i+1
                var k = nums.count - 1
                
                while j < k {
                    let newSum = number + nums[j] + nums[k]
                    let newGap = abs(target - newSum)
                    
                    if newGap == 0 {
                        return newSum
                    }
                    else if newGap < gap {
                        gap = newGap
                        sumClosesToTarget = newSum
                    }
                    
                    if newSum < target {
                        j += 1
                    }
                    else {
                        k -= 1
                    }
                }
            }
            
            return sumClosesToTarget
        }
    }
}
