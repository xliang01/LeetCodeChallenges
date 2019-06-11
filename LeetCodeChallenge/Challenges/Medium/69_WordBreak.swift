//
//  69_WordBreak.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/9/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class WordBreak: Runnable {
    func runTests() {
//        let solution = SolutionRecursion()
        let solution = SolutionRecursionMemoization()
        print(solution.wordBreak("leetcode", ["leet", "code"]))
        print(solution.wordBreak("applepenapple", ["apple", "pen"]))
        print(solution.wordBreak("catsanddogs", ["cats", "dog", "sand", "and", "cat"]))
        print(solution.wordBreak("bb", ["b", "aa", "bc", "dd", "efb"]))
        print(solution.wordBreak("aaaaaaa", ["aaa", "aaaa"]))
        print(solution.wordBreak("cars", ["car","ca","rs"]))
    }
    
    private class SolutionBFSMemoization {
        func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
            let lookup = Set(wordDict)
            let chars = Array<Character>(s)
            if s.isEmpty { return false }
            
            var visited = [Bool](repeating: false, count: s.count)
            var queue = [Int]()
            queue.append(0)
            
            while !queue.isEmpty {
                let startingIndex = queue.removeFirst()
                if visited[startingIndex] { continue }
                
                for index in (startingIndex + 1...s.count) {
                    let segment = String(chars[startingIndex..<index])
                    if lookup.contains(segment) {
                        queue.append(index)
                        if index == s.count {
                            return true
                        }
                    }
                }
                visited[startingIndex] = true
            }
            
            return false
        }
    }
    
    private class SolutionRecursionMemoization {
        func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
            let lookup = Set(wordDict)
            let chars = Array<Character>(s)
            if s.isEmpty { return false }
            
            var memoize = [Bool](repeating: false, count: s.count)
            return segment(chars, 0, lookup, &memoize)
        }
        
        private func segment(_ chars: [Character], _ startIndex: Int, _ lookup: Set<String>, _ memoize: inout [Bool]) -> Bool {
            if startIndex == chars.count { return true }
            
            for index in startIndex+1...chars.count {
                let segmentValue = String(chars[startIndex..<index])
                if memoize[index-1] {
                    return true
                }
                else if lookup.contains(segmentValue) && segment(chars, index, lookup, &memoize) {
                    memoize[index-1] = true
                    return true
                }
            }
            return false
        }
    }
    
    private class SolutionRecursion {
        func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
            let lookup = Set(wordDict)
            let chars = Array<Character>(s)
            if s.isEmpty { return false }
            return segment(chars, 0, lookup)
        }
        
        private func segment(_ chars: [Character], _ startIndex: Int, _ lookup: Set<String>) -> Bool {
            if startIndex == chars.count { return true }
            
            for index in startIndex+1...chars.count {
                let segmentValue = String(chars[startIndex..<index])
                if lookup.contains(segmentValue) && segment(chars, index, lookup) {
                    return true
                }
            }
            return false
        }
    }
}
