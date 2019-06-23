//
//  IsAnagram.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/23/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class IsAnagram: Runnable {
    func runTests() {
        let solution = SolutionArray()
        print(solution.isAnagram("abc", "cde"))
    }
    
    private class SolutionArray {
        func isAnagram(_ s: String, _ t: String) -> Bool {
            let aAscii = Int(Character("a").asciiValue!)
            var counts = [Int](repeating: 0, count: 26)
            
            for char in s {
                let letter = Int(char.asciiValue!) - aAscii
                counts[letter] += 1
            }
            
            for char in t {
                let letter = Int(char.asciiValue!) - aAscii
                counts[letter] -= 1
            }
            
            for c in counts {
                if c != 0 { return false }
            }
            
            return true
        }
    }
}
