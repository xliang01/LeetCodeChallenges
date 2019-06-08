//
//  60_DailyTemperatures.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/8/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class DailyTemperatures: Runnable {
    func runTests() {
        let solution = SolutionStack()
        print(solution.dailyTemperatures([73, 74, 75, 71, 69, 72, 76, 73]))
    }
    
    private class SolutionStack {
        /**
            Solution:
         
            For each daily temperature, append to a stack. If the stack is not empty for the current temperature, go through the entire
            stack and find if the previous temperature is less than this current temperature. If it is, set the difference in days and
            pop off the previous temperature.
         
            The stack can hold indices so we can calculate the difference between days.
         
            Performance Analysis:
         
            Time Complexity: O(N) to loop through each element. Even though the stack can grow, say up to W times, it's still O(N+W) which
            is O(N) if W is small and the stack does not have to pop the entire list.
         
            Space Complexity: O(W) for the amount of space allowed on the stack. W could be N in the worst case, but not in the average case.
         */
        func dailyTemperatures(_ T: [Int]) -> [Int] {
            var answers = [Int](repeating: 0, count: T.count)
            var stack = [Int]()
            
            for (index, temp) in T.enumerated() {
                while
                    !stack.isEmpty,
                    let lastIndex = stack.last,
                    temp > T[lastIndex] {
                    
                    answers[lastIndex] = index - lastIndex
                    stack.removeLast()
                }
                stack.append(index)
            }
            
            return answers
        }
    }
    
    private class SolutionQuatradic {
        func dailyTemperatures(_ T: [Int]) -> [Int] {
            var answers = [Int]()
            
            for i in 0..<T.count {
                var days = 0
                for j in i+1..<T.count {
                    if T[j] > T[i] {
                        days = j - i
                    }
                }
                answers.append(days)
            }
            
            return answers
        }
    }
}
