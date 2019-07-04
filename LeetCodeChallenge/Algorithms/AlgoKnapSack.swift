//
//  AlgoKnapSack.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/4/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class AlgoKnapSack: Runnable {
    func runTests() {
        let solution = KnapSackTopDown()
        print(solution.knapSack(capacity: 8, weights: [1, 2, 3, 4, 5], amounts: [30, 20, 5, 10, 8]))
        print(solution.knapSack(capacity: 50, weights: [10, 20, 30], amounts: [60, 100, 120]))
        print(solution.knapSack(capacity: 150, weights: [50, 30, 20, 10, 50], amounts: [1, 56, 42, 78, 12]))
    }
    
    private class KnapSackTopDown {
        func knapSack(capacity: Int,
                      weights: [Int],
                      amounts: [Int]) -> Int {
            if weights.count == 1 {
                return amounts[0]
            }
            
            var memo = [String: Int]()
            return knapSackChoices(capacity, weights, amounts, 0, &memo)
        }
        
        /**
            T: O(N*W)
         */
        private func knapSackChoices(_ remainingWeight: Int,
                                     _ weights: [Int],
                                     _ amounts: [Int],
                                     _ currentItem: Int,
                                     _ memo: inout [String: Int]) -> Int {
            let key = "\(currentItem)-\(remainingWeight)"
            
            // If we no longer have any items, return.
            if currentItem >= weights.count {
                return 0
            }
            // If the remaining weight is less than 0, can't go.
            if remainingWeight < 0 {
                return 0
            }
            // If the remaining weight is exactly 0, we want to return this amount because we've used all available weights at this point.
            else if remainingWeight == 0 {
                return amounts[currentItem]
            }
            // If memoized, just return it.
            else if let memoizedAmount = memo[key] {
                return memoizedAmount
            }
            // If the weight is greater than the remaining weight, take the next one. This one doesn't make sense.
            else if weights[currentItem] > remainingWeight {
                return knapSackChoices(remainingWeight,
                                       weights,
                                       amounts,
                                       currentItem + 1,
                                       &memo)
            }
            // Try taking this item and see if yields the max results. Otherwise, don't take it and see if it can yield the max results.
            else {
                let takingThisItem = amounts[currentItem] + knapSackChoices(remainingWeight - weights[currentItem],
                                                                            weights,
                                                                            amounts,
                                                                            currentItem + 1,
                                                                            &memo)
                let notTakingThisItem = knapSackChoices(remainingWeight,
                                                        weights,
                                                        amounts,
                                                        currentItem + 1,
                                                        &memo)
                
                // Memoize it.
                memo[key] = max(takingThisItem, notTakingThisItem)
                return memo[key]!
            }
        }
    }
}
