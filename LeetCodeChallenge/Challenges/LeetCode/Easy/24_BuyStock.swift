//
//  24_BuyStock.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 4/7/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class BuyStock: Runnable {
    func runTests() {
        let solution1 = SolutionIterate()
        print(solution1.maxProfit([7,1,5,3,6,4]))
        print(solution1.maxProfit([7,6,4,3,1]))
        print(solution1.maxProfit([2,4,1]))
    }
    
    private class SolutionIterate {
        /**
            Solution:
         
            Iterate through the array of prices and find two ranges that could produce a profit. If the profit
            is higher than the previous profit, keep track of this one. Ultimately, return this profit since it'll
            be the highest among all potential profits.
         
            Performance:
         
            Time Complexity: O(N) because we have to iterate through the list of prices.
            Space Complexity: O(1) because no new data structures are used.
         */
        func maxProfit(_ prices: [Int]) -> Int {
            var smallestIndex = 0
            var largestIndex = 0
            var maxProfit = 0
            
            for index in (0..<prices.count) {
                /*
                    Find the index of the smallest value. Once found, reset the largest number index as the new smallest number
                    index because every number after the smallest index will be used for a new profit margin.
                 */
                if prices[index] < prices[smallestIndex] {
                    smallestIndex = index
                    largestIndex = index
                }
                /*
                    If a new large value is found, calculate the profit. If the profit is greater than the previous profit,
                    record it.
                 */
                if prices[index] > prices[largestIndex] {
                    largestIndex = index
                    let profit = prices[largestIndex] - prices[smallestIndex]
                    if profit > maxProfit {
                        maxProfit = profit
                    }
                }
            }
            return maxProfit
        }
    }
    
    //        Example Iterations
    //        [2,4,1,7]
    //         i
    //         s
    //         l
    //           i
    //         s
    //           l
    //             i
    //             s
    //             l
    //               i
    //             s
    //               l
    //            [7,6,4,3,1]
    //             s
    //             l
    //             i
    //
    //               i
    //               s
    //               l
    //                 i
    //                 s
    //                 l
    //
    //            [7,1,5,3,6,4]
    //             i
    //             s
    //             l
    //
    //               i
    //               s
    //               l
    //
    //                 i
    //               s
    //                 l
    //
    //                   i
    //               s
    //                 l
    //
    //                     i
    //               s
    //                     l
    //                        i
    //               s
    //                     l
    //
    //            [7,2,5,1,6,4]
    //             i
    //             s
    //             l
    //
    //               i
    //               s
    //               l
    //
    //                 i
    //               s
    //                 l
    //
    //                   i
    //                   s
    //                 l
    //
    //                     i
    //                   s
    //                     l
    //                        i
    //                   s
    //                     l
    //
    //                [98,100,101,1,6,4]
    //                 i
    //                 s
    //                 l
    //                     i
    //                 s
    //                     l
    //                         i
    //                 s
    //                         l
    //                            i
    //                            s
    //                            l
    //                               i
    //                            s
    //                               l
    //                                  i
    //                            s
    //                               l
}
