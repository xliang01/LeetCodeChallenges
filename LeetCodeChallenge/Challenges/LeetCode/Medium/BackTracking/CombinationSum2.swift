//
//  CombinationSum2.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/27/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class CombinationSum2: Runnable {
    func runTests() {
        let solution = SolutionBackTrack()
        print(solution.combinationSum2([1,1,2,3,6,7], 7))
    }
    
    private class SolutionBackTrack {
        func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
            let candidates = candidates.sorted()
            var results = [[Int]]()
            var combo = [Int]()
            sum(target, &results, candidates, &combo, 0)
            return results
        }
        
        private func sum(_ remaining: Int, _ results: inout [[Int]], _ candidates: [Int], _ combo: inout [Int], _ start: Int) {
            if remaining < 0 { return }
            else if remaining == 0 { results.append(combo) }
            else {
                for i in start..<candidates.count {
                    if i != start && candidates[i] == candidates[i-1] { continue }
                    combo.append(candidates[i])
                    sum(remaining - candidates[i], &results, candidates, &combo, i + 1)
                    combo.removeLast()
                }
            }
        }
    }

}
