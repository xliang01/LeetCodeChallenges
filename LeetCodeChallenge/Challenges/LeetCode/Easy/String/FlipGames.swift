//
//  FlipGames.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/30/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class FlipGames: Runnable {
    func runTests() {
        let solution = SolutionCharArray()
        print(solution.generatePossibleNextMoves("++++"))
    }
    
    // T: O(N^2) - Note, turning chars to String takes O(N) operation
    // S: O(N)
    private class SolutionCharArray {
        func generatePossibleNextMoves(_ s: String) -> [String] {
            var chars = Array<Character>(s)
            var idx = 0
            var ans = [String]()
            
            while idx < chars.count - 1 {
                if chars[idx] == chars[idx + 1] && chars[idx] == "+" {
                    chars[idx] = "-"
                    chars[idx + 1] = "-"
                    ans.append(String(chars))
                    chars[idx] = "+"
                    chars[idx + 1] = "+"
                }
                idx += 1
            }
            
            return ans
        }
    }
}
