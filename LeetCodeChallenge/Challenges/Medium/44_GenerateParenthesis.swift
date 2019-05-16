//
//  44_GenerateParenthesis.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 5/15/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class GenerateParenthesis: Runnable {
    func runTests() {
        let solution = SolutionBackTracking()
        print(solution.generateParenthesis(3))
    }
    
    private class SolutionBackTracking {
        func generateParenthesis(_ n: Int) -> [String] {
            var answer = [String]()
            backTrack(answer: &answer, cur: "", open: n, close: n)
            return answer
        }
        
        func backTrack(answer: inout [String], cur: String, open: Int, close: Int) {
            if open == 0 && close == 0 {
                answer.append(cur)
                return
            }
            
            if open > 0 {
                backTrack(answer: &answer, cur: cur + "(", open: open - 1, close: close)
            }
            if open < close {
                backTrack(answer: &answer, cur: cur + ")", open: open, close: close - 1)
            }
        }
    }
}
