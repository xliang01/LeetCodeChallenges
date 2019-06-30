//
//  InterleavingStrings.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/21/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class InterleavingStrings: Runnable {
    func runTests() {
        let solution = SolutionRecursive()
        print(solution.isInterleave("aab", "axy", "aaxaby"))
        print(solution.isInterleave("aab", "axy", "abaaxy"))
    }
    
    private class SolutionRecursive {
        func isInterleave(_ s1: String, _ s2: String, _ s3: String) -> Bool {
            var cache = [[String]: Bool]()
            return isInterleaveDP(s1, s2, s3)
        }
        
        func isInterleaveDP(_ x: String, _ y: String, _ s: String) -> Bool {
            if x.isEmpty && y.isEmpty && s.isEmpty {
                return true
            }
            if s.isEmpty {
                return false
            }
            
            let interleavesX = !x.isEmpty && x.first! == s.first! && isInterleaveDP(String(x.dropFirst()), y, String(s.dropFirst()))
            let interleavesY = !y.isEmpty && y.first! == s.first! && isInterleaveDP(x, String(y.dropFirst()), String(s.dropFirst()))
            
            return interleavesX || interleavesY
        }
    }
}
