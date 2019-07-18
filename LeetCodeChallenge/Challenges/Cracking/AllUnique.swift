//
//  AllUnique.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/16/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class AllUniqueCharacters: Runnable {
    func runTests() {
        let solution1 = SolutionASCIIArray()
        let solution2 = SolutionSort()
        let solution3 = SolutionSet()
        
        print(solution1.isUnique("Abc"))
        print(solution1.isUnique("Abc-1234-a"))
        
        print(solution2.isUnique("Abc"))
        print(solution2.isUnique("Abc-1234-a"))
        
        print(solution3.isUnique("Abc"))
        print(solution3.isUnique("Abc-1234-a"))
    }
    
    private class SolutionSet {
        func isUnique(_ s: String) -> Bool {
            let chars = Array<Character>(s)
            var set = Set<Character>()
            
            for c in chars {
                if !set.contains(c) { set.insert(c) }
                else { return false }
            }
            
            return true
        }
    }
    
    private class SolutionASCIIArray {
        func isUnique(_ s: String) -> Bool {
            var asciiValues = [Int](repeating: 0, count: 255)
            let chars = Array<Character>(s)
            
            for c in chars {
                let asciiValue = Int(c.asciiValue!)
                asciiValues[asciiValue] += 1
                if asciiValues[asciiValue] > 1 {
                    return false
                }
            }
            
            return true
        }
    }
    
    private class SolutionSort {
        func isUnique(_ s: String) -> Bool {
            let chars = Array<Character>(s).sorted()
            for i in (0..<chars.count-1) {
                if chars[i] == chars[i + 1] {
                    return false
                }
            }
            return true
        }
    }
}
