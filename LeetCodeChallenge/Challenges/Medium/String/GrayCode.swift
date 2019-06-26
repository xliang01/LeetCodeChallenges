//
//  GrayCode.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/25/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class GrayCode: Runnable {
    func runTests() {
        let solution = SolutionBackTrack()
        print(solution.grayCode(2))
    }
    
    private class SolutionBackTrack {
        func grayCode(_ n: Int) -> [Int] {
            var result = [Int]()
            var val = 0
            
            backtracking(n - 1, &val, &result)
            return result
        }
        
        private func backtracking(_ n: Int, _ val: inout Int, _ result: inout [Int]) {
            if n == -1 {
                result.append(val)
                return
            }
            
            backtracking(n - 1, &val, &result)
            val = val ^ (1 << n)
            backtracking(n - 1, &val, &result)
        }
    }
}
