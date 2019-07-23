//
//  MinCostTrainRide.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/18/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class MinCostTrainRide: Runnable {
    func runTests() {
        let solution = SolutionDP()
        print(solution.mincostTickets([1,4,6,7,8,20], [2,7,15]))
    }
    
    class SolutionDP {
        func mincostTickets(_ days: [Int], _ costs: [Int]) -> Int {
            var dp = [Int](repeating: 0, count: 366)
            
            for d in days {
                dp[d] = costs[0]
            }
            
            for d in 1...days[days.count - 1] {
                if dp[d] == 0 {
                    dp[d] = dp[d-1]
                }
                else {
                    dp[d] = min(dp[d-1] + costs[0],
                                dp[max(0, d-7)] + costs[1],
                                dp[max(0, d-30)] + costs[2])
                }
            }
            return dp[days[days.count-1]]
        }
    }
    
    class SolutionDPRecursion {
        var schedule = Set<Int>()
        var costs = [Int]()
        
        func mincostTickets(_ days: [Int], _ costs: [Int]) -> Int {
            var memo = [Int: Int]()
            
            self.costs = costs
            for d in days {
                schedule.insert(d)
            }
            
            return dp(1,
                      &memo)
        }
        
        private func dp(_ day: Int,
                        _ memo: inout [Int: Int]) -> Int {
            if day > 366 {
                return 0
            }
            else if let minCost = memo[day] {
                return minCost
            }
            
            if schedule.contains(day) {
                memo[day] = min(dp(day + 1, &memo) + costs[0],
                                dp(day + 7, &memo) + costs[1],
                                dp(day + 30, &memo) + costs[2])
            }
            else {
                memo[day] = dp(day + 1, &memo)
            }
            return memo[day]!
        }
    }
}
