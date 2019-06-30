//
//  Missing_Number.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/23/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class MissingNumber: Runnable {
    func runTests() {
        let solution = SolutionNums()
        print(solution.missingNumber([0, 1, 2, 4]))
    }
    
    private class SolutionNums {
        func missingNumber(_ nums: [Int]) -> Int {
            let n = nums.count + 1
            let sum = (n * (n - 1)) / 2
            let numsSum = nums.reduce(0, { (total, value) -> Int in
                return total + value
            })
            return sum - numsSum
        }
    }
}
