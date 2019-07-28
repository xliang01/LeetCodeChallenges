//
//  PalindromePermutations.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/27/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class PalindromePermutations: Runnable {
    func runTests() {
        let solution = SolutionArrayCount()
        print(solution.isPalindromePermutation("Taco cat"))
        print(solution.isPalindromePermutation("Tact Coa"))
        print(solution.isPalindromePermutation("Tact Coa"))
        print(solution.isPalindromePermutation("atco cta"))
        print(solution.isPalindromePermutation("atco ctt"))
    }
    
    private class SolutionArrayCount {
        func isPalindromePermutation(_ string: String) -> Bool {
            guard !string.isEmpty else { return true }
            if string.count == 1 { return true }
            
            var ascii = [Int](repeating: 0, count: 26)
            let characters = Array<Character>(string.lowercased())
            
            var characterCount = 0
            for c in characters {
                if c != " " {
                    ascii[Int(c.asciiValue! - Character("a").asciiValue!)] += 1
                    characterCount += 1
                }
            }
            
            // For odds, only 1 letter should have 1 count. All other letters must have an even count.
            if characterCount % 2 == 1 {
                var singleCount = 0
                for count in ascii {
                    if count == 1 {
                        singleCount += 1
                        if singleCount > 1 {
                            return false
                        }
                    }
                    else if count % 2 == 1 {
                        return false
                    }
                }
                if singleCount == 0 {
                    return false
                }
            }
            // For evens, all letters must have an even count.
            else {
                for count in ascii {
                    if count % 2 == 1 {
                        return false
                    }
                }
            }
            
            return true
        }
    }
}
