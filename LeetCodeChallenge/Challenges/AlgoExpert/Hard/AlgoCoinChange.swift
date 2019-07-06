//
//  AlgoCoinChange.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/5/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class AlgoCoinChange: Runnable {
    func runTests() {
        let solution = SolutionRecusion()
        print(solution.coinChange([1, 5], 7))
    }
    
    private class SolutionRecusion {
        func coinChange(_ coins: [Int], _ amount: Int) -> Int {
            var memo = [Int?](repeating: nil, count: amount + 1)
            return coinChange(coins, amount, &memo)
        }
        
        func coinChange(_ coins: [Int],
                        _ amount: Int,
                        _ memo: inout [Int?]) -> Int {
            if amount < 0 { return -1 }
            else if amount == 0 { return 0 }
            else if let minVal = memo[amount] { return minVal }
            
            var minCoins = Int.max
            for coin in coins {
                if amount >= coin {
                    let minCoinsCount = coinChange(coins, amount - coin, &memo)
                    if minCoinsCount != -1 {
                        minCoins = min(minCoins, minCoinsCount + 1)
                    }
                }
            }
            
            memo[amount] = (minCoins == Int.max) ? -1 : minCoins
            return memo[amount]!
        }

    }
}
