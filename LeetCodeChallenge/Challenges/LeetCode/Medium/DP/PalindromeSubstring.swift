//
//  PalindromeSubstring.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/18/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class PalindromeSubstring: Runnable {
    func runTests() {
        let solution = SolutionDP()
        print(solution.countSubstrings("abc"))
        print(solution.countSubstrings("aaa"))
    }
    
    private class SolutionDP {
        func countSubstrings(_ s: String) -> Int {
            var chars = Array<Character>(s).map { Int($0.asciiValue! - Character("a").asciiValue!) }
            if chars.count == 1 { return 1 }
            var dp = [[Bool]](repeating: [Bool](repeating: false, count: chars.count), count: chars.count)
            
            var count = 0
            for i in 0..<chars.count {
                dp[i][i] = true
                count += 1
            }
            
            for i in 0..<chars.count-1 {
                if chars[i] == chars[i+1] {
                    dp[i][i+1] = true
                    count += 1
                }
            }
            
            if chars.count >= 3 {
                for window in 3...chars.count {
                    for start in 0...chars.count - window {
                        let end = start + window - 1
                        let isEdgeSame = (chars[start] == chars[end])
                        let isPalindrome = isEdgeSame && dp[start + 1][end - 1]
                        dp[start][end] = isPalindrome
                        
                        if isPalindrome {
                            count += 1
                        }
                    }
                }
            }
            
            return count
        }
    }
}
