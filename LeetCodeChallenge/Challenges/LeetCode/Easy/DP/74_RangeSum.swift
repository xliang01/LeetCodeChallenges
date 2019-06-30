//
//  74_RangeSum.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/12/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class RangeSum: Runnable {
    func runTests() {
        let solution = SolutionNumArray([-2, 0, 3, -5, 2, -1])
        print(solution.sumRange(0, 2))
        print(solution.sumRange(2, 5))
        print(solution.sumRange(0, 5))
    }
    
    private class SolutionNumArray {
        var sum: [Int]
        init(_ nums: [Int]) {
            sum = [Int](repeating: 0, count: nums.count + 1)
            for i in 0..<nums.count {
                sum[i + 1] = sum[i] + nums[i];
            }
        }
        
        func sumRange(_ i: Int, _ j: Int) -> Int {
            return sum[j + 1] - sum[i];
        }
    }
}
