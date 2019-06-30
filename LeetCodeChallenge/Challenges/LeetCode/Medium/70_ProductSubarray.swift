//
//  70_ProductSubarray.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/12/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class ProductSubArray: Runnable {
    func runTests() {
        let solution = SolutionDP()
        print(solution.maxProduct([-4, -3, 0, -2, -10]))
    }
    
    private class SolutionDP {
        func maxProduct(_ nums: [Int]) -> Int {
            var maxP = nums[0]
            var minP = nums[0]
            var ans = nums[0]
            
            for i in 1..<nums.count {
                let num = nums[i]
                if num > 0 {
                    maxP = max(maxP * num, num)
                    minP = min(minP * num, num)
                }
                else {
                    let temp = maxP
                    maxP = max(minP * num, num)
                    minP = min(temp * num, num)
                }
                
                ans = max(ans, maxP)
            }
            return ans
        }
    }
}
