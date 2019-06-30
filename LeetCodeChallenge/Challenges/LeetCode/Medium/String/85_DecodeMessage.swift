//
//  85_DecodeMessage.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/19/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class DecodeMessage: Runnable {
    func runTests() {
        let solution1 = SolutionRecursionWithMemoization()
        print(solution1.numDecodings("111"))
        
        let solution2 = SolutionDPBottomUp()
        print(solution2.numDecodings("101"))
        print(solution2.numDecodings("110"))
    }
    
    class SolutionDPBottomUp {
        func numDecodings(_ s: String) -> Int {
            if s.isEmpty { return 1 }
            let ints = s.map { Int(String($0))! }
            
            // Need + 1 in order to hold the base case of dp[0] = 1
            var dp = [Int](repeating: 0, count: s.count + 1)
            dp[0] = 1
            dp[1] = ints[0] != 0 ? 1 : 0
            
            if s.count == 1 {
                return dp[1]
            }
            
            for i in 2...s.count {
                let firstDigit = ints[i-1..<i].first!
                let secondDigits = Array(ints[i-2..<i])
                let secondDigit = secondDigits[0]*10 + secondDigits[1]
                
                if firstDigit != 0 {
                    dp[i] += dp[i - 1]
                }
                
                if secondDigit >= 10 && secondDigit <= 26 {
                    dp[i] += dp[i - 2]
                }
            }
            
            return dp[s.count]
        }
    }
    
    class SolutionRecursionWithMemoization {
        func numDecodings(_ s: String) -> Int {
            if s.isEmpty { return 1 }
            let ints = Array<Character>(s).map { Int(String($0))! }
            var mem = [Int?](repeating: nil, count: s.count + 1)
            
            return decode(ints, s.count, &mem)
        }
        
        func decode(_ ints: [Int], _ k: Int, _ mem: inout [Int?]) -> Int {
            // Everything is validated.
            if k == 0 {
                return 1
            }
            
            let startIndex = ints.count - k
            
            // Not valid if any of the codes by itself is 0
            if ints[startIndex] == 0 {
                return 0
            }
            
            if mem[k] != nil {
                return mem[k]!
            }
            
            // Grab the first string and check if the substrings can decode.
            var result = decode(ints, k - 1, &mem)
            
            // If we have at least 2 strings to decode with, check if the values are less than 26.
            // If the values are between 10 and 26, this is a valid case.
            if k >= 2 && ints[startIndex] * 10 + ints[startIndex + 1] <= 26 {
                result += decode(ints, k - 2, &mem)
            }
            
            mem[k] = result
            
            return result
        }
    }

}
