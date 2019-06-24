//
//  AllSubSets.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/24/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class AllSubsets: Runnable {
    func runTests() {
        let solution = SolutionBackTrack()
        print(solution.subsets([1, 2, 3]))
    }
    
    private class SolutionBackTrack {
        func subsets(_ nums: [Int]) -> [[Int]] {
            var answers = [[Int]]()
            backtrack([], nums, &answers)
            return answers
        }
        
        private func backtrack(_ prefix: [Int], _ suffix: [Int], _ answers: inout [[Int]]) {
            answers.append(prefix)
            if suffix.isEmpty { return }
            
            var prefix = prefix
            var suffix = suffix
            
            for val in suffix {
                prefix.append(val)
                suffix.removeFirst()
                backtrack(prefix, suffix, &answers)
                prefix.removeLast()
            }
        }
    }
}
