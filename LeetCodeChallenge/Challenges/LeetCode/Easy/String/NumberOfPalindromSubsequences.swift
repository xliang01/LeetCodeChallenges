//
//  PalindromeSubstring.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/1/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class NumberOfPalindromSubsequences: Runnable {
    func runTests() {
        let solution = SolutionDP()
        print(solution.longestSubstring(s: "aa"))
        print(solution.longestSubstring(s: "aaa"))
        print(solution.longestSubstring(s: "abc"))
        print(solution.longestSubstring(s: "abba"))
        print(solution.longestSubstring(s: "abbac"))
    }
    
    private class SolutionDP {
        func longestSubstring(s: String) -> Int {
            guard !s.isEmpty else { return 0 }
            guard s.count > 1 else { return 1 }
            
            var count = 0
            let chars = Array<Character>(s)
            var dp = [[Bool]](repeating: [Bool](repeating: false, count: s.count), count: s.count)
            
            // Single letters must be true.
            for i in chars.indices {
                dp[i][i] = true
                count += 1
            }
            
            // Look at longest palindrome length
            for i in 0..<chars.count - 1 {
                if chars[i] == chars[i + 1] {
                    dp[i][i + 1] = true
                    count += 1
                }
            }
            
            if chars.count >= 3 {
                for window in 2..<chars.count {
                    for start in 0..<chars.count-window {
                        let end = start + window
                        if chars[start] == chars[end] && dp[start+1][end-1] {
                            dp[start][end] = true
                            count += 1
                        }
                    }
                }
            }
            
            return count
        }
    }
}
