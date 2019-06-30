//
//  PartitionLabels.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/23/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class PartitionLabels: Runnable {
    func runTests() {
        let solution = SolutionArray()
        print(solution.partitionLabels("ababcbacadefegdehijhklij"))
    }
    
    private class SolutionArray {
        let aAscii = Int(Character("a").asciiValue!)
        func partitionLabels(_ S: String) -> [Int] {
            var last = [Int](repeating: 0, count: 26)
            for (i, c) in S.enumerated() {
                last[Int(c.asciiValue!)-aAscii] = i
            }
            
            var ans = [Int]()
            var j = 0
            var anchor = 0
            for (i, c) in S.enumerated() {
                j = max(j, last[Int(c.asciiValue!)-aAscii])
                if i == j {
                    ans.append(i - anchor + 1)
                    anchor = i + 1
                }
            }
            
            return ans
        }
    }
}
