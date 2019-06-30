//
//  CombinationSum.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/27/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class CombinationSum: Runnable {
    func runTests() {
        let solution = SolutionBackTrack()
        print(solution.combinationSum([2,3,6,7], 7))
    }
    
    private class SolutionBackTrack {
        func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
            var results = [[Int]]()
            var combo = [Int]()
            
            sum(target, &results, 0, candidates, &combo)
            return results
        }
        
        private func sum(_ remaining: Int, _ results: inout [[Int]], _ start: Int, _ candidates: [Int], _ combo: inout [Int]) {
            if remaining < 0 {
                return
            }
            else if remaining == 0 {
                results.append(combo)
            }
            else {
                for i in start..<candidates.count {
                    combo.append(candidates[i])
                    sum(remaining - candidates[i], &results, i, candidates, &combo)
                    combo.removeLast()
                }
            }
        }
    }
}
