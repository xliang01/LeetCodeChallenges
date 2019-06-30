////
////  89_MaxAdjacentNumbers.swift
////  LeetCodeChallenge
////
////  Created by Xiao Liang on 6/20/19.
////  Copyright © 2019 TrackVia, Inc. All rights reserved.
////
//
//import Foundation
//
//class MaxAdjacentNumbers: Runnable {
//    func runTests() {
//        
//    }
//    
//    private class SolutionDP {
////        func findMaxAdjacentNumbers(_ nums: [Int]) -> Int {
////            if nums.isEmpty { return 0 }
////            if nums.count == 1 { return nums[1] }
////            if nums.count == 2 { return max(nums[0], nums[1]) }
////            
////            var dp = [Int](repeating: 0, count: nums.count + 1)
////            dp[0] = 0
////            dp[1] = nums[0]
////            dp[2] = max(nums[0], nums[1])
////            
////            for i in 2..<nums.count {
////                dp[i] = max(d[i] + dp[i-2], dp[i-1]
////            }
////            
////            return 0
////        }
////    }
//}
