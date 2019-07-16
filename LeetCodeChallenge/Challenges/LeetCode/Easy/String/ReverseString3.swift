//
//  ReverseString3.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/16/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class ReverseString3: Runnable {
    func runTests() {
        
    }
    
    private class SolutionSwapInPlace {
        func reverseWords(_ s: String) -> String {
            if s.isEmpty || s.count == 1 { return s }
            
            var chars = Array<Character>(s)
            var startIdx = 0
            for (index, c) in chars.enumerated() {
                if c == " " {
                    swap(&chars, startIdx, index-1)
                    startIdx = index + 1
                }
            }
            
            swap(&chars, startIdx, chars.count-1)
            return String(chars)
        }
        
        private func swap(_ chars: inout [Character],
                          _ i: Int,
                          _ j: Int) {
            var i = i
            var j = j
            
            while i < j {
                let temp = chars[i]
                chars[i] = chars[j]
                chars[j] = temp
                i += 1
                j -= 1
            }
        }
    }
}
