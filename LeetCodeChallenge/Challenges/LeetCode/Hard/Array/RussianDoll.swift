//
//  RussianDoll.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/11/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class RussianDoll: Runnable {
    func runTests() {
        let solution = SolutionSortIncreasingSubsequence()
        print(solution.subsequence([[1,2],[2,1],[2,3],[5,4],[6,4],[6,7],[2,3]]))
    }
    
    private class SolutionSortIncreasingSubsequence {
        func subsequence(_ nums: [[Int]]) -> Int {
            
            // O(N) + O(NLogN)
            var nums = Set(nums).sorted { (lhs, rhs) -> Bool in
                return lhs[0] < rhs[0]
            }
            
            var dp = [Int](repeating: 0, count: nums.count)
            var maxCount = Int.min
            dp[0] = 1
            
            for i in 1..<nums.count {
                let currentDoll = Doll(nums[i])
                for j in 0..<i {
                    let doll = Doll(nums[j])
                    
                    if doll < currentDoll {
                        dp[i] = max(dp[j] + 1, dp[i])
                        maxCount = max(maxCount, dp[i])
                    }
                }
            }
            
            return dp[nums.count - 1]
        }
    }
    
    struct Doll: Equatable {
        let width: Int
        let height: Int
        
        init(_ val: [Int]) {
            width = val[0]
            height = val[1]
        }
        
        static func < (lhs: Doll, rhs: Doll) -> Bool {
            return
                lhs.width < rhs.width &&
                lhs.height < rhs.height
        }
    }
}
