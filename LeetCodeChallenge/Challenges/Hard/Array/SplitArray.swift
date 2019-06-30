//
//  SplitArray.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/29/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class SplitArray: Runnable {
    func runTests() {
        let solution = SolutionDFS()
        let nums = [7,2,5,10,8]
        let m = 2
        solution.dfs(nums, m, 0, 0, 0, 0)
        print(solution.answer)
    }
    
    private class SolutionDFS {
        var answer: Int = Int.max
        
        func dfs(_ nums: [Int], _ maxArrays: Int, _ i: Int, _ subArrayCount: Int, _ sum: Int, _ currentMax: Int) {
            if i == nums.count && subArrayCount == maxArrays {
                answer = min(answer, sum)
                return
            }
            if i == nums.count {
                return
            }
            if i > 0 {
                dfs(nums,
                    maxArrays,
                    i + 1,
                    subArrayCount,
                    sum + nums[i],
                    max(currentMax, sum + nums[i]))
            }
            if subArrayCount < maxArrays {
                dfs(nums,
                    maxArrays,
                    i + 1,
                    subArrayCount + 1,
                    nums[i],
                    max(currentMax, nums[i]))
            }
        }
    }
}
