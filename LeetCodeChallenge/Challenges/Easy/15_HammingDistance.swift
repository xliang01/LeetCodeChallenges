//
//  15_HammingDistance.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 3/24/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class HammingDistance: Runnable {
    func runTests() {
        let solution1 = SolutionBitShift()
        print(solution1.hammingDistance(1, 4))
        print(solution1.hammingDistance(14, 4))
    }
    
    private class SolutionBitShift {
        /**
            Solution:
         
            Using XOR between x and y, count the number of bits that are 1s. XOR will determine the difference
            between two bit numbers. To count the number of bits that are 1s, continue to shift the number to
            the right until the value is 0. As the number is shifted, determine if the right most bit is 1 by
            ANDing it with 1.
         
            So if x = 2, and y = 4:
         
            Binary Representations
         
            2 = 010
            4 = 100
         
            Step 1: Use XOR to determine the number of different bits.
         
            2 XOR 4 -> 010 XOR 100 -> 110
         
            Step 2: Shift until 0
         
            110 -> Count = 0 because right most bit is 0, not 1. Shift right using >> 1.
            011 -> Count = 1 because right most bit is 1. Shift right using >> 1.
            001 -> Count = 2 because right most bit is 1. Shift right using >> 1.
            000 -> Final Answer = 2, because everything has been shifted and the value is 0.
         
            Performance:
         
            Runtime Complexity: O(N) for the number of bits to shift if x and y are maximum distance from each other.
            Space Complexity: O(1). No data structures are used other than count values and shifts.
         */
        func hammingDistance(_ x: Int, _ y: Int) -> Int {
            // GUARD: If both numbers are the same, there is no hamming distance.
            guard x != y else {
                return 0
            }
            
            var valueXOR = x ^ y
            var shiftCounts = 0
            
            while valueXOR != 0 {
                shiftCounts += valueXOR & 1
                valueXOR = valueXOR >> 1
            }
            return shiftCounts
        }
    }
}
