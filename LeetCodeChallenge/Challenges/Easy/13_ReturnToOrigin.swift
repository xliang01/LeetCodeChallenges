//
//  13_ReturnToOrigin.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 3/24/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class ReturnToOrigin: Runnable {
    func runTests() {
        let solution1 = SolutionAddSubtract()
        print(solution1.judgeCircle("UD"))
        print(solution1.judgeCircle("LL"))
        
        let solution2 = SolutionFastArray()
        print(solution2.judgeCircle("UD"))
        print(solution2.judgeCircle("LL"))
    }
    
    private class SolutionAddSubtract {
        func judgeCircle(_ moves: String) -> Bool {
            var v = 0
            var h = 0
            
            guard moves.count % 2 == 0 else {
                return false
            }
            
            Array<Character>(moves).forEach { character in
                if character == "U" {
                    v += 1
                }
                else if character == "D" {
                    v -= 1
                }
                else if character == "L" {
                    h -= 1
                }
                else if character == "R" {
                    h += 1
                }
            }
            return h == 0 && v == 0
        }
    }
    
    private class SolutionFastArray {
        /**
            Solution:
         
            Given a list of moves, increment the count +1 for U, D, L, R. At the end, ensure U and D,
            L and R have the same count values. This ensures the position is back to 0. Otherwise,
            it cannot be back to origin.
         
            Note: If the number of moves is odd, we can never return back to origin.
         
            Performance:
         
            Time Complexity: O(N) because we have to traverse through every element to increment and decrement if the count is even. O(1) if odd.
            Space Complexity: O(1) because we only use 255 and no more. O(1) if odd.
         */
        func judgeCircle(_ moves: String) -> Bool {
            // GUARD: If the input is odd, return since you can't get back to origin with odd moves.
            guard moves.unicodeScalars.count % 2 == 0 else {
                return false
            }
            
            var characters = [Int](repeating: 0, count: 255)
            for ascii in moves.unicodeScalars {
                characters[Int(ascii.value)] += 1
            }
            return characters[85] == characters[68] && characters[76] == characters[82]
        }
    }
}
