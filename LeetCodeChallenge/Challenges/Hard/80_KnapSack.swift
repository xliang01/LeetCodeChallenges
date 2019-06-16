//
//  80_KnapSack.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/15/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class KnapSack: Runnable {
    func runTests() {
        let solution = SolutionBottomUp()
        print(solution.knapSack(capacity: 8, weights: [1, 2, 3, 4, 5], amounts: [30, 20, 5, 10, 8]))
        print(solution.knapSack(capacity: 50, weights: [10, 20, 30], amounts: [60, 100, 120]))
        print(solution.knapSack(capacity: 150, weights: [50, 30, 20, 10, 50], amounts: [1, 56, 42, 78, 12]))
        
//        let capacity = 150
//        let amounts = [1, 56, 42, 78, 12]
//        let weights = [50, 30, 20, 10, 50]
//        let capacity = 50
//        let amounts = [60, 100, 120]
//        let weights = [10, 20, 30]
//
//        print(solution.knapSack(weight: capacity,
//                                worth: 0,
//                                weights: weights,
//                                amounts: amounts,
//                                used: &used,
//                                level: weights.count))
//
//        let solution2 = SolutionRecursiveForEveryNumber()
//        print(solution2.knapSack(capacity: capacity,
//                                 weights: weights,
//                                 amounts: amounts,
//                                 n: weights.count))
    }
    
    private class SolutionRecursiveForEveryNumber {
        func knapSack(capacity: Int,
                      weights: [Int],
                      amounts: [Int],
                      n: Int) -> Int {
            if n == 0 || capacity == 0 {
                return 0
            }
            
            if weights[n-1] > capacity {
                return knapSack(capacity: capacity,
                                weights: weights,
                                amounts: amounts,
                                n: n-1)
            }
            
            let amountWithCurrentWeight = knapSack(capacity: capacity - weights[n-1],
                                                   weights: weights,
                                                   amounts: amounts,
                                                   n: n-1) + amounts[n-1]
            
            let amountWithoutCurrentWeight = knapSack(capacity: capacity,
                                                      weights: weights,
                                                      amounts: amounts,
                                                      n: n-1)
            
            return max(amountWithCurrentWeight, amountWithoutCurrentWeight)
        }
    }
    
    private class SolutionBottomUp {
        func knapSack(capacity: Int,
                      weights: [Int],
                      amounts: [Int]) -> Int {
            
            var dp: [[Int]]  = [[Int]](repeating: [Int](repeating: 0, count: capacity + 1), count: weights.count + 1)
            
            for row in 1...weights.count {
                // Get the item weight for this row.
                let itemWeight = weights[row - 1]
                
                for col in 1...capacity {
                    // Get the capacity for this row.
                    let currentCapacity = col
                    // Get the item value for this row.
                    let itemValue = amounts[row - 1]
                    
                    // If the item weight is less than capacity, try to take it.
                    if itemWeight <= currentCapacity {
                        // What's remaining if I take this item?
                        let remainingWeight = currentCapacity - itemWeight
                        // If I take this item, find the sub problem of whatever is remaining
                        let takeThisItemAmount = itemValue + dp[row - 1][remainingWeight]
                        // If I don't take this item, then calculate what was taken before.
                        let doNotTakeThisItemAmount = dp[row - 1][col]
                        // Get the max between the two.
                        dp[row][col] = max(takeThisItemAmount, doNotTakeThisItemAmount)
                    }
                    // If the weight is greater, take the previous ones that have already been taken since we can't take this one.
                    else {
                        let doNotTakeThisItemAmountBecauseOverWeight = dp[row - 1][col]
                        dp[row][col] = doNotTakeThisItemAmountBecauseOverWeight
                    }
                }
            }
            
            for row in dp {
                print(row)
            }
            return dp[weights.count][capacity]
        }
    }
}
