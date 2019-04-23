//
//  29_ParenthesisCheck.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 4/14/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class ParenthesisCheck: Runnable {
    func runTests() {
        let solution = SolutionStack()
        print(solution.isValid("()]"))
        print(solution.isValid("()"))
        print(solution.isValid("()[]{}"))
        print(solution.isValid("{[()]}"))
        print(solution.isValid("()]"))
    }
    
    class SolutionStack {
        let map =
        [
            Character("]"):Character("["),
            Character(")"):Character("("),
            Character("}"):Character("{")
        ]
        
        /**
            Solution:
         
            Use a stack to push the left sided symbols. Pop the stack if a matching right symbol appears. If the top of the stack
            doesn't have the left symbol when a symbol appears, this is an invalid expression. Otherwise pop.
         
            Performance:
         
            Time Complexity: O(N) because we need to iterate through the entire string.
            Space Complexity: O(N) because the stack could store up to N at a time.
         */
        func isValid(_ s: String) -> Bool {
            if s.isEmpty {
                return true
            }
            else if s.count % 2 != 0 {
                return false
            }
            
            var stack = [Character]()
            let characters = Array<Character>(s)
            
            for character in characters {
                if let symbol = map[character] {
                    if stack.isEmpty {
                        return false
                    }
                    else if stack.last! != symbol {
                        return false
                    }
                    _ = stack.popLast()
                }
                else {
                    stack.append(character)
                }
            }
            
            return stack.isEmpty
        }
    }
}
