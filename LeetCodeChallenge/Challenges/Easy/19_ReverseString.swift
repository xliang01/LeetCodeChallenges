//
//  19_ReverseString.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 3/28/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class ReverseString: Runnable {
    func runTests() {
        var input: [Character] = ["h","e","l","l","o"]
        let solution1 = SolutionIndexSwap()
        solution1.reverseString(&input)
        print(input)
    }
    
    private class SolutionIndexSwap {
        /**
            Solution:
         
            Reverse a string by flipping index i, and complement j (N-1-i).
         
            Performance:
         
            Time Complexity - O(N) because we have to iterate N/2, which is O(N).
            Space Complexity - O(1) because we don't create any more data structures.
         */
        func reverseString(_ s: inout [Character]) {
            for i in (0..<(s.count/2)) {
                let j = s.count - 1 - i
                let temp = s[i]
                s[i] = s[j]
                s[j] = temp
            }
        }
    }
}
