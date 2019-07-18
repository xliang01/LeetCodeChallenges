//
//  PaintingHouses.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/16/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class PaintingHouses: Runnable {
    func runTests() {
        let solution = SolutionDP()
        print(solution.minCost([[17,2,17],[16,16,5],[14,3,19]]))
    }
    
    private class SolutionDP {
        func minCost(_ costs: [[Int]]) -> Int {
            if costs.isEmpty { return 0 }
            var redCost = costs[0][0]
            var greenCost = costs[0][1]
            var blueCost = costs[0][2]
            
            var idx = 1
            while idx < costs.count {
                let currRedCost = costs[idx][0] + min(greenCost, blueCost)
                let currGreenCost = costs[idx][1] + min(redCost, blueCost)
                let currBlueCost = costs[idx][2] + min(redCost, greenCost)
                
                redCost = currRedCost
                greenCost = currGreenCost
                blueCost = currBlueCost
                
                idx += 1
            }
            
            return min(redCost, greenCost, blueCost)
        }
    }
}
