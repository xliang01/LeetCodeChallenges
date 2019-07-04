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
        let solution = SolutionRecursiveMemo()
        print(solution.isInterleave("aab", "axy", "aaxaby"))
        print(solution.isInterleave("aab", "axy", "abaaxy"))
    }
    
    // T: O(M + N) because the 2^(M + N) is elimated with additional work.
    // S: O(M + N) for the memoized table.
    class SolutionRecursiveMemo {
        func isInterleave(_ s1: String,
                          _ s2: String,
                          _ s3: String) -> Bool {
            let s1Chars = Array<Character>(s1)
            let s2Chars = Array<Character>(s2)
            let s3Chars = Array<Character>(s3)
            var memo = [[Bool?]](repeating: [Bool?](repeating: nil, count: s2.count), count: s1.count)
            return isInterLeave(s1Chars, 0, s2Chars, 0, s3Chars, 0, &memo)
        }
        
        func isInterLeave(_ s1: [Character],
                          _ s1Index: Int,
                          _ s2: [Character],
                          _ s2Index: Int,
                          _ s3: [Character],
                          _ s3Index: Int,
                          _ memo: inout [[Bool?]]) -> Bool {
            if s3Index == s3.count && s2Index == s2.count && s1Index == s1.count {
                return true
            }
            else if s1Index == s1.count {
                return String(s2[s2Index..<s2.count]) == String(s3[s3Index..<s3.count])
            }
            else if s2Index == s2.count {
                return String(s1[s1Index..<s1.count]) == String(s3[s3Index..<s3.count])
            }
            else if let memo = memo[s1Index][s2Index] {
                return memo
            }
            
            let pickS1 =
                s1[s1Index] == s3[s3Index] &&
                isInterLeave(s1, s1Index + 1, s2, s2Index, s3, s3Index + 1, &memo)
            
            let pickS2 =
                s2[s2Index] == s3[s3Index] &&
                isInterLeave(s1, s1Index, s2, s2Index + 1, s3, s3Index + 1, &memo)
            
            memo[s1Index][s2Index] = pickS1 || pickS2
            return memo[s1Index][s2Index]!
        }
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
