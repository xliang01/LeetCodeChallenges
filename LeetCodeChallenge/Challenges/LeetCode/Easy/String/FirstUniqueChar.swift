//
//  FirstUniqueChar.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/23/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class FirstUniqueChar: Runnable {
    func runTests() {
        let solution = SolutionArray()
        print(solution.firstUniqChar("aabcc"))
    }
    
    private class SolutionArray {
        func firstUniqChar(_ s: String) -> Int {
            var counts = [Int](repeating: 0, count: 26)
            let offset = Int(Character("a").asciiValue!)
            
            for char in s {
                let ascii = Int(char.asciiValue!) - offset
                counts[ascii] += 1
            }
            
            for (i, char) in s.enumerated() {
                let ascii = Int(char.asciiValue!) - offset
                if counts[ascii] == 1 { return i }
            }
            return -1
        }
    }
}
