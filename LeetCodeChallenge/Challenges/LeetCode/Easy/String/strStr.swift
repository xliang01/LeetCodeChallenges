//
//  strStr.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/1/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class strStr: Runnable {
    func runTests() {
        let solution = SolutionArray()
        print(solution.strStrWindow("mississippi", "issip"))
    }
    
    private class SolutionArray {
        func strStr(_ haystack: String, _ needle: String) -> Int {
            if needle.isEmpty { return 0 }
            if needle.count > haystack.count { return 0 }
            
            let hcs = Array<Character>(haystack)
            let ncs = Array<Character>(needle)
            
            for i in 0..<(haystack.count - needle.count) {
                if hcs[i] == ncs.first {
                    for j in 0..<needle.count {
                        if hcs[i + j] != ncs[j] { break }
                        else if j == needle.count - 1 { return i }
                    }
                }
            }
            return -1
        }
        
        // T: O(N*M)
        // S: O(1)
        func strStrWindow(_ haystack: String, _ needle: String) -> Int {
            if needle.isEmpty { return 0 }
            else if needle.count > haystack.count { return -1 }
            
            for i in 0...(haystack.count - needle.count) {
                let startIdx = haystack.index(haystack.startIndex, offsetBy: i)
                let endIdx = haystack.index(haystack.startIndex, offsetBy: i+needle.count)
                if String(haystack[startIdx..<endIdx]) == needle {
                    return i
                }
            }
            return -1
        }
    }
}
