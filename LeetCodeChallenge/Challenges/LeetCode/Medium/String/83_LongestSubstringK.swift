//
//  83_LongestSubstringK.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/18/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class LongestSubstringK: Runnable {
    func runTests() {
        let solution = SolutionRecursion()
        print(solution.longestSubstring("aaabb", 3))
    }
    
    private class SolutionRecursion {
        func longestSubstring(_ s: String, _ k: Int) -> Int {
            // If the string is less than K, there's no way we can get to K
            if s.count < k { return 0 }
            
            // Find the letters that accumulate over k.
            let aAscii = Int(Character("a").asciiValue!)
            var counts = [Int](repeating: 0, count: 26)
            let chars = Array<Character>(s)
            
            for char in chars {
                counts[Int(char.asciiValue!) - aAscii] += 1
            }
            
            var startIndex = Int.min
            var maxLen = 0
            
            for (i, char) in chars.enumerated() {
                let asciiOffset = Int(char.asciiValue!) - aAscii
                
                // If this letter is in the substring, keep track of the first position.
                if counts[asciiOffset] >= k && startIndex < 0 {
                    startIndex = i
                }
                // For every letter, check which character is the breaking point, meaning this must be the
                // character that isn't in the substring.
                else if counts[asciiOffset] < k && startIndex >= 0 {
                    let startIdx = s.index(s.startIndex, offsetBy: startIndex)
                    let endIdx = s.index(s.startIndex, offsetBy: i)
                    maxLen = max(maxLen, longestSubstring(String(s[startIdx..<endIdx]), k))
                    startIndex = Int.min
                }
            }
            // If the start index is 0, it means all letters satisified the constraint.
            if startIndex == 0 {
                return s.count
            }
            // If the start index has some left over, it means we need to find the longest substring
            // toward the end.
            else if startIndex > 0 {
                let startIdx = s.index(s.startIndex, offsetBy: startIndex)
                maxLen = max(maxLen, longestSubstring(String(s[startIdx..<s.endIndex]), k))
            }
            return maxLen
        }
    }
}
