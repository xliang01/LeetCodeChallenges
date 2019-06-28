//
//  TrappingRainWater.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/26/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class TrappingRainWater: Runnable {
    func runTests() {
        let solution = SolutionScan()
        print(solution.trap([0,1,0,2,1,0,1,3,2,1,2,1]))
    }
    
    private class SolutionOneScan {
        func trap(_ height: [Int]) -> Int {
            var l = 0
            var r = height.count - 1
            
            var maxL = 0
            var maxR = 0
            var vol = 0
            
            while l < r {
                if height[l] < height[r] {
                    if height[l] >= maxL {
                        maxL = height[l]
                    }
                    else {
                        vol += maxL - height[l]
                    }
                    l += 1
                }
                else {
                    if height[r] >= maxR {
                        maxR = height[r]
                    }
                    else {
                        vol += maxR - height[r]
                    }
                    r -= 1
                }
            }
            
            return vol
        }
    }
    
    private class SolutionScan {
        func trap(_ height: [Int]) -> Int {
            if height.isEmpty { return 0 }
            if height.count < 3 { return 0 }
            
            var maxes = [Int](repeating: Int.min, count: height.count)
            
            var maxH = Int.min
            for r in 0..<height.count {
                maxH = max(maxH, height[r])
                maxes[r] = maxH
            }
            
            maxH = Int.min
            for l in stride(from: height.count - 1, to: -1, by: -1) {
                maxH = max(maxH, height[l])
                maxes[l] = min(maxH, maxes[l])
            }
            
            var vol = 0
            for i in 0..<height.count {
                vol += (maxes[i] - height[i])
            }
            
            return vol
        }
    }
}
