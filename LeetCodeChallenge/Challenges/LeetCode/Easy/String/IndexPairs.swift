//
//  IndexPairs.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/30/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class IndexPairs: Runnable {
    func runTests() {
        let solution = SolutionMatch()
        print(solution.indexPairs("thestoryofleetcodeandme", ["story","fleet","leetcode"]))
    }
    
    /*
        T: O(T * W) + O(T * Log(T)) - Worst case is length of the string times length of words, plus the sort of the position indices.
        S: O(T) - Worst case is every word matches every letter in the text. So we have T pairs.
    */
    private class SolutionMatch {
        func indexPairs(_ text: String, _ words: [String]) -> [[Int]] {
            let tChars = Array<Character>(text)
            var pos = [[Int]]()
            
            for w in words {
                let wChars = Array<Character>(w)
                if tChars.count - wChars.count < 0 { continue }
                
                for i in 0...tChars.count - wChars.count {
                    var match = true
                    for j in 0..<wChars.count {
                        if tChars[i + j] != wChars[j] {
                            match = false
                            break
                        }
                    }
                    if match {
                        pos.append([i, i + wChars.count-1])
                    }
                }
            }
            
            return pos.sorted(by: { lhs, rhs in
                if lhs[0] != rhs[0] {
                    return lhs[0] < rhs[0]
                }
                else {
                    return lhs[1] < rhs[1]
                }
            })
        }
    }
}
