//
//  AlgoLongestCommonSubsequence.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/4/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class AlgoLongestCommonSubsequence: Runnable {
    func runTests() {
        let solution = SolutionRecursion()
        print(solution.longestCommonSubsequence("ZXVVYZW", "XKYKZPW"))
        print(solution.longestCommonSubsequence("A", "B"))
        print(solution.longestCommonSubsequence("A", "A"))
        print(solution.longestCommonSubsequence("A", "AA"))
        print(solution.longestCommonSubsequence("CX", "DY"))
    }
    
    private class SolutionRecursion {
        func longestCommonSubsequence(_ s1: String, _ s2: String) -> [Character] {
            if s1.isEmpty || s2.isEmpty { return [] }
            if s1 == s2 { return Array<Character>(s1) }
            
            let s1Chars = Array<Character>(s1)
            let s2Chars = Array<Character>(s2)
            var memo = [[[Character]?]](repeating: [[Character]?](repeating: nil, count: s2.count), count: s1.count)
            
            let longest = longestCommonSubsequence(s1Chars,
                                                   0,
                                                   s2Chars,
                                                   0,
                                                   &memo)
            return longest
        }
        
        private func longestCommonSubsequence(_ s1: [Character],
                                              _ s1Index: Int,
                                              _ s2: [Character],
                                              _ s2Index: Int,
                                              _ memo: inout [[[Character]?]]) -> [Character] {
            if s1Index == s1.count || s2Index == s2.count { return [] }
            
            var subSequence = [Character]()
            
            if let mem = memo[s1Index][s2Index] {
                return mem
            }
            
            if s1[s1Index] == s2[s2Index] {
                subSequence.append(s1[s1Index])
                subSequence.append(contentsOf: longestCommonSubsequence(s1,
                                                                        s1Index + 1,
                                                                        s2,
                                                                        s2Index + 1,
                                                                        &memo))
            }
            // If they don't match, try the next S1
            else {
                let takeS1 = longestCommonSubsequence(s1,
                                                      s1Index + 1,
                                                      s2,
                                                      s2Index,
                                                      &memo)
                
                let takeS2 = longestCommonSubsequence(s1,
                                                      s1Index,
                                                      s2,
                                                      s2Index + 1,
                                                      &memo)
                
                subSequence = takeS1.count > takeS2.count ? takeS1 : takeS2
            }
            
            memo[s1Index][s2Index] = subSequence
            return memo[s1Index][s2Index]!
        }
    }
}
