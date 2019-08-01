//
//  FindOccurrences.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/31/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class FindOccurrences: Runnable {
    func runTests() {
        let solution = SolutionIndex()
        print(solution.findOcurrences("we will we will rock you", "we", "will"))
    }
    
    private class SolutionIndex {
        func findOcurrences(_ text: String, _ first: String, _ second: String) -> [String] {
            let words = text.split(separator: " ")
            var idx = 0
            var ans = [String]()
            
            while idx < words.count - 1 {
                if words[idx] == first && words[idx + 1] == second {
                    if idx + 2 < words.count {
                        ans.append(String(words[idx + 2]))
                    }
                }
                idx += 1
            }
            
            return ans
        }
    }
}
