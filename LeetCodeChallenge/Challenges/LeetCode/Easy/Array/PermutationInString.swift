//
//  PermutationInString.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/3/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class PermutationInString: Runnable {
    func runTests() {
        let solution = SolutionArrayOptimized()
        print(solution.checkInclusion("ab", "eidbaooo"))
        print(solution.checkInclusion("ab", "eidboaoo"))
    }
    
    private class SolutionArrayOptimized {
        func checkInclusion(_ s1: String, _ s2: String) -> Bool {
            if s1.count > s2.count { return false }
            
            let chars1 = Array<Character>(s1)
            var chars2 = Array<Character>(s2)
            
            var s1Counts = [Int](repeating: 0, count: 26)
            var s2Counts = [Int](repeating: 0, count: 26)
            
            let windowSize = chars1.count
            for i in 0..<windowSize {
                s1Counts[getAsciiOffset(chars1[i])] += 1
                s2Counts[getAsciiOffset(chars2[i])] += 1
            }
            
            for i in 0..<(chars2.count-windowSize) {
                if matches(s1Counts, s2Counts) { return true }
                s2Counts[getAsciiOffset(chars2[i + windowSize])] += 1
                s2Counts[getAsciiOffset(chars2[i])] -= 1
            }
            
            return matches(s1Counts, s2Counts)
        }
        
        private func getAsciiOffset(_ char: Character) -> Int {
            let offset = Int(char.asciiValue!) - Int(Character("a").asciiValue!)
            return offset
        }
        
        private func matches(_ counts1: [Int], _ counts2: [Int]) -> Bool {
            for i in 0..<26 {
                if counts1[i] != counts2[i] {
                    return false
                }
            }
            return true
        }
    }
    
    private class SolutionArrayWindow {
        func checkInclusion(_ s1: String, _ s2: String) -> Bool {
            if s1.count > s2.count { return false }
            
            let chars1 = Array<Character>(s1)
            var chars2 = Array<Character>(s2)
            var s1Counts = [Int](repeating: 0, count: 26)
            let windowSize = chars1.count
            for char in chars1 { s1Counts[getAsciiOffset(char)] += 1 }
            
            for i in 0...(chars2.count-windowSize) {
                var s2Counts = [Int](repeating: 0, count: 26)
                for windowIndex in i..<(i + windowSize) {
                    let char2 = chars2[windowIndex]
                    s2Counts[getAsciiOffset(char2)] += 1
                }
                
                var hasPermutation = true
                for m in 0..<26 {
                    hasPermutation = hasPermutation && s1Counts[m] == s2Counts[m]
                }
                if hasPermutation { return true }
            }
            
            return false
        }
        
        private func getAsciiOffset(_ char: Character) -> Int {
            let offset = Int(char.asciiValue!) - Int(Character("a").asciiValue!)
            return offset
        }
    }
}
