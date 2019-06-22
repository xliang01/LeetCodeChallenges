//
//  95_UniqueBinarySearchTrees.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/21/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

// https://www.youtube.com/watch?v=GgP75HAvrlY

class UniqueBinarySearchTrees: Runnable {
    func runTests() {
        
    }
    
    private class SolutionEquation {
        func numTrees(_ n: Int) -> Int {
            if n == 0 { return 0 }
            else if n == 1 { return 1 }
            else if n == 2 { return 2 }
            
            var G = [Int](repeating: 0, count: n + 1)
            G[0] = 1
            G[1] = 1
            
            for N in 2...n {
                for F in 1...N {
                    G[N] += G[F - 1] * G[N - F]
                }
            }
            return G[n]
        }
    }
}
