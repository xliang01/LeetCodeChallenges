//
//  ShortestWayFormSubstring.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/17/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class ShortestWayFormSubstring: Runnable {
    func runTests() {
        let solution = SolutionDP()
        print(solution.shortestWay("aaaaa", "aaaaaaaaaaaaa"))
    }
    
    private class SolutionDP {
        func shortestWay(_ source: String, _ target: String) -> Int {
            let source = Array<Character>(source).map { Int($0.asciiValue!) - Int(Character("a").asciiValue!) }
            let target = Array<Character>(target).map { Int($0.asciiValue!) - Int(Character("a").asciiValue!) }
            
            // Check base case for non existing character
            var ascii = [Int](repeating: 0, count: 26)
            for a in source { ascii[a] += 1 }
            for a in target { if ascii[a] == 0 { return -1 } }
            
            return shortestWay(source,
                               0,
                               target,
                               0)
        }
        
        private func shortestWay(_ source: [Int],
                                 _ sourceIdx: Int,
                                 _ target: [Int],
                                 _ targetIdx: Int) -> Int {
            if targetIdx == target.count {
                return 1
            }
            
            let nextTargetIndex = (source[sourceIdx] == target[targetIdx]) ? targetIdx + 1 : targetIdx
            let sourceIdx = sourceIdx + 1
            let count = (sourceIdx == source.count) && (nextTargetIndex < target.count) ? 1 : 0
            
            return shortestWay(source,
                               sourceIdx % source.count,
                               target,
                               nextTargetIndex) + count
        }
    }
}
