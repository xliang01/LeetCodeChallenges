//
//  RemoveVowels.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/15/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class RemoveVowels: Runnable {
    func runTests() {
        let solution = SolutionSwap()
        print(solution.removeVowels("leetcodeisacommunityforcoders"))
    }
    
    private class SolutionSwap {
        func removeVowels(_ S: String) -> String {
            let vowels = Set<Character>(["a", "e", "i", "o", "u"])
            var chars = Array<Character>(S)
            var swapIdx = 0
            
            for (i, c) in chars.enumerated() {
                if !vowels.contains(c) {
                    swap(&chars, i, swapIdx)
                    swapIdx += 1
                }
            }
            
            if swapIdx >= chars.count { return S }
            else { return String(chars[0..<swapIdx]) }
        }
        
        private func swap(_ chars: inout [Character],
                          _ i: Int,
                          _ j: Int) {
            let temp = chars[i]
            chars[i] = chars[j]
            chars[j] = temp
        }
    }
}
