//
//  47_CoinChange.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 5/23/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class CoinChange: Runnable {
    func runTests() {
        let solution1 = SolutionRecursionProper()
        print(solution1.coinChange([1, 2 , 5], 11))
        print(solution1.coinChange([], 1))
        print(solution1.coinChange([1], 1))
        print(solution1.coinChange([2], 1))
        print(solution1.coinChange([1], 2))
        print(solution1.coinChange([2, 4, 5], 8))
        print(solution1.coinChange([186, 419, 83, 408], 6249))
        
        print()
        let solution2 = SolutionBottomUp()
        print(solution2.coinChange([1, 2 , 5], 11))
        print(solution2.coinChange([], 1))
        print(solution2.coinChange([1], 1))
        print(solution2.coinChange([2], 1))
        print(solution2.coinChange([1], 2))
        print(solution2.coinChange([2, 4, 5], 8))
        print(solution2.coinChange([186, 419, 83, 408], 6249))
        
        print()
        let solution3 = SolutionTopDown()
        print(solution3.coinChange([1, 2 , 5], 11))
        print(solution3.coinChange([], 1))
        print(solution3.coinChange([1], 1))
        print(solution3.coinChange([2], 1))
        print(solution3.coinChange([1], 2))
        print(solution3.coinChange([2, 4, 5], 8))
        print(solution3.coinChange([186, 419, 83, 408], 6249))
    }
    
    private class SolutionTopDown {
        func coinChange(_ coins: [Int], _ amount: Int) -> Int {
            var amounts = [Int: Int]()
            return coinChange(coins, amount, &amounts)
        }
        
        private func coinChange(_ coins: [Int], _ amount: Int, _ amounts: inout [Int: Int]) -> Int {
            // Return 0 if 0 as base case. This just means no more sub amounts can form the subset sum.
            if amount == 0 {
                return 0
            }
            // Return -1 if any coins cannot sum to the ammount.
            else if amount < 0 {
                return -1
            }
            // Return the memoized solution.
            else if let cachedAmount = amounts[amount] {
                return cachedAmount
            }
            else {
                var minAmount = Int.max
                // For each coin, calculate how many sub sums it needs to equate to the amount.
                for coin in coins {
                    if amount > coin {
                        let result = coinChange(coins, amount - coin, &amounts)
                        // If the result is found, return the min amount of all the possible coin change iterations.
                        if result != -1 {
                            minAmount = min(minAmount, result + 1)
                        }
                    }
                }
                // Memoize and return the minimum amount.
                minAmount = minAmount != Int.max ? minAmount : -1
                amounts[amount] = minAmount
                return minAmount
            }
        }
    }
    
    // Solution is here: https://www.youtube.com/watch?v=jgiZlGzXMBw
    /*
        Create an array with all the possible sums up to the amount. Work bottom up
        and reference each complment to see if it can add up to the current change.
    */
    private class SolutionBottomUp {
        func coinChange(_ coins: [Int], _ amount: Int) -> Int {
            if amount == 0 { return 0 }
            
            var counts = [Int](repeating: amount + 1, count: amount + 1)
            counts[0] = 0
            
            // For i = 1 to the entire amount, these are the min amount of counts that make up all combinations of coin sums
            // up to the amount.
            for subAmount in 1...amount {
                var minCount = Int.max
                // For each coin sum combination, iterate through all coins and find the minimum amount of coins that can make
                // the sum.
                for coin in coins {
                    // The sub amount has to be greater than the coin. Otherwise, don't do anything since you can't have previous
                    // sums if the current value is smaller than the coin.
                    if subAmount >= coin {
                        let prevCount = counts[subAmount - coin]
                        // The previous count can't be -1. This means the previous number couldn't be found.
                        if prevCount != -1 {
                            minCount = min(minCount, prevCount + 1)
                        }
                    }
                }
                counts[subAmount] = (minCount == Int.max) ? -1 : minCount
            }
            return counts.last ?? -1
        }
    }
    
    private class SolutionRecursionProper {
        func coinChange(_ coins: [Int], _ amount: Int) -> Int {
            return coinChange(0, coins, amount)
        }
        
        private func coinChange(_ idxCoin: Int, _ coins: [Int], _ amount: Int) -> Int {
            guard amount != 0 else {
                return 0
            }
            
            if idxCoin < coins.count && amount > 0 {
                let maxVal = amount / coins[idxCoin]
                var minCost = Int.max
                
                for x in 0...maxVal {
                    if amount >= x * coins[idxCoin] {
                        let res = coinChange(idxCoin + 1, coins, amount - x * coins[idxCoin])
                        if res != -1 { minCost = min(minCost, res + x) }
                    }
                }
                return minCost == Int.max ? -1 : minCost
            }
            return -1
        }
    }
    
    private class SolutionRecursion {
        func coinChange(_ coins: [Int], _ amount: Int) -> Int {
            let coins = coins.sorted()
            let cache = Set(coins)
            return getCount(cache, coins, amount, coins.count)
        }
        
        private func getCount(_ cache: Set<Int>, _ coins: [Int], _ amount: Int, _ endIndex: Int) -> Int {
            if endIndex < 0 { return -1 }
            
            for i in (0..<endIndex).reversed() {
                if coins[i] > amount {
                    return getCount(cache, coins, amount, endIndex - 1)
                }
                else if amount % coins[i] == 0 {
                    return amount / coins[i]
                }
                else {
                    let quot = amount / coins[i]
                    let comp = amount - quot * coins[i]
                    if cache.contains(comp) {
                        return quot + 1
                    }
                    else {
                        let count = getCount(cache, coins, comp, endIndex - 1)
                        return count > 0 ? count + quot : -1
                    }
                }
            }
            return -1
        }
    }
}
