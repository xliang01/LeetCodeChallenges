//
//  AlgoFourSum.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/8/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class AlgoFourSum: Runnable {
    func runTests() {
        let solution = SolutionLoop()
        print(solution.fourNumbersSum([7,6,4,-1,1,2], 16))
    }
    
    private class SolutionLoop {
        func fourNumbersSum(_ nums: [Int], _ target: Int) -> [[Int]] {
            let k = 4
            
            if nums.count < k { return [] }
            var nums = nums.sorted()
            var ans = [[Int]]()
            
            for i in 0..<k {
                if i != 0 && nums[i] == nums[i-1] { continue }
                for j in 1..<k {
                    if j != 0 && nums[j] == nums[j-1] { continue }
                    var k = j + 1
                    var l = nums.count - 1
                    while k < l {
                        let sum = nums[i] + nums[j] + nums[k] + nums[l]
                        if sum == target {
                            ans.append([nums[i], nums[j], nums[k], nums[l]])
                            break
                        }
                        else if sum > target { l -= 1 }
                        else if sum < target { k += 1 }
                    }
                }
            }
            
            return ans
        }
    }
}
