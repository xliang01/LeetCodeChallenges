//
//  MinimumWindowSubstring.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/3/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class MinimumWindowSubstring: Runnable {
    func runTests() {
        let solution = SolutionSlidingWindow()
//        print(solution.minWindow("ADOBECODEBANC", "ABC"))
        print(solution.minWindow("aa", "aa"))
    }
    
    private class SolutionSlidingWindow {
        func minWindow(_ s: String, _ t: String) -> String {
            // If the t count is greater than s, no point in going further, just return.
            if (s.count < t.count) { return "" }
            // No sense in doing anything if t is empty.
            if (t.count == 0) { return "" }
        
            // This is the window we are constantly checking against.
            var tWindow = [Character: Int]()
            let tChars = Array<Character>(t)
            // For every character in t chars, create map and store it.
            for c in tChars { tWindow[c, default: 0] += 1 }
            // This is the amount of keys required to match.
            let required = tWindow.count
            // For every character in s.
            var chars = Array<Character>(s)
            // Create the sliding window.
            var window = [Character: Int]()
            
            // Left pointer to sliding window.
            var left = 0
            // Right pointer to sliding window.
            var right = 0
            // Formed is how many we'll need in order to know if we have enough letters to meet the sliding window.
            var formed = 0
            // Left index for the string.
            var leftIndex = -1
            // Right index for the string.
            var rightIndex = -1
            var stringLength = Int.max
            
            // While the right pointer of the window is less than the string, start to slide the  window.
            while right < chars.count {
                let c = chars[right]
                // Increase the count of this character.
                window[c, default: 0] += 1
                // If the count is equal to the T Window, we've found a match.
                if let tCount = tWindow[c], tCount == window[c] {
                    // Ensure formed is incremented because this character is in the window.
                    formed += 1
                }
                // While the left is less than the right, and our formed is equal to the desired, slide the window to the left.
                while left <= right && formed == required {
                    // Get the legnth of the string.
                    let length = right - left + 1
                    // If the new length is less than the current min string length, decrease the length.
                    if length < stringLength {
                        // Mark the left and right index.
                        stringLength = length
                        leftIndex = left
                        rightIndex = right
                    }
                    
                    // Shrink the window on the left.
                    let c = chars[left]
                    // Remove this character from the window.
                    window[c] = (window[c] ?? 0) - 1
                    // If the window character no longer matches the tWindow, it means this is invalid now.
                    if let windowCount = window[c], let tCount = tWindow[c], windowCount < tCount {
                        // It's no longer formed to the required.
                        formed -= 1
                    }
                    // Keep shrinking the window.
                    left += 1
                }
                // Expand the window.
                right += 1
            }
            
            if stringLength == Int.max { return "" }
            return String(chars[leftIndex...rightIndex])
        }
    }
}
