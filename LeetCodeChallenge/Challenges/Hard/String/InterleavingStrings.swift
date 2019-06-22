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
        print(solution.isInterleave("aabcc", "dbbca", "aadbbcbcac"))
//        print(solution.isInterleave("aabcc", "dbbca", "aadbbbaccc"))
    }
    
    private class SolutionRecursive {
        func isInterleave(_ s1: String, _ s2: String, _ s3: String) -> Bool {
            var cache = [[String]: Bool]()
            return isInterleaveDP(s1, s2, s3/*, &cache*/)
        }
        
        func isInterleaveDP(_ s1: String, _ s2: String, _ s3: String/*, _ cache: inout [[String]: Bool]*/) -> Bool {
            if s1.isEmpty && s2.isEmpty {
                return s3.isEmpty
            } else if s1.isEmpty || s2.isEmpty {
                return s3 == s1 + s2
            }
            
            guard s1.count + s2.count == s3.count else { return false }
            
            // aabcc
            // dbbca
            // aadbbcbcac
            
            // abcc
            // dbbca
            // adbbcbcac
            
            // bcc
            // dbbca
            // dbbcbcac
            
            // bcc
            // bbca
            // bbcbcac
            
            // cc
            // bbca
            // bcbcac
            
            // cc
            // bca
            // cbcac
            
            // c
            // bca
            // bcac
            
            // c
            // ca
            // cac
            
            // ""
            // ca
            // ac
            
            // Next case
            // c
            // a
            // ac
            
            let s1 = Array(s1), s2 = Array(s2), s3 = Array(s3)
            if s1[0] == s3[0] && isInterleaveDP(String(s1.dropFirst()), String(s2), String(s3.dropFirst())/*, &cache*/) {
//                cache[key] = true
                return true
            }
            if s2[0] == s3[0] && isInterleaveDP(String(s1), String(s2.dropFirst()), String(s3.dropFirst())/*, &cache*/) {
//                cache[key] = true
                return true
            }
//            cache[key] = false
            return false
        }
    }
}
