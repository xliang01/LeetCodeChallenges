//
//  53_LetterCombinations.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/1/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class LetterCombinations: Runnable {
    func runTests() {
        let solution1 = SolutionBackTrace()
        print(solution1.letterCombinations("333"))
    }
    
    private class SolutionBackTrace {
        /**
            Solution:
         
            Back track and get every combination of letters available.
         
            Performance:
         
            Time complexity: O(M^N) or O(3^N + 4^M) for all N numbers that have 3 letters, and M numbers that have 4 letters.
            Space complexity: O(M^N) or O(3^N + 4^M) to hold all combination of numbers.
         */
        func letterCombinations(_ digits: String) -> [String] {
            guard !digits.isEmpty else { return [] }
            let numbers = Array<Character>(digits).compactMap { Int("\($0)") }
            let lookup: [Int: [Character]] = [0: [],
                                              1: [],
                                              2: ["a", "b", "c"],
                                              3: ["d", "e", "f"],
                                              4: ["g", "h", "i"],
                                              5: ["j", "k", "l"],
                                              6: ["m", "n", "o"],
                                              7: ["p", "q", "r", "s"],
                                              8: ["t", "u", "v"],
                                              9: ["w", "x", "y", "z"]]
            var answer = [Character]()
            var answers = [String]()
            let mapping = numbers.reduce([[Character]]()) { (results, number) -> [[Character]] in
                var results = results
                results.append(lookup[number]!)
                return results
            }
            
            combination(mapping, &answer, &answers, 0)
            
            return answers
        }
        
        private func combination(_ mapping: [[Character]],
                                 _ answer: inout [Character],
                                 _ answers: inout [String],
                                 _ numberIndex: Int) {
            if numberIndex == mapping.count {
                answers.append(String(answer))
                return
            }
            
            let letters = mapping[numberIndex]
            if letters.isEmpty {
                combination(mapping, &answer, &answers, numberIndex + 1)
            }
            else {
                for letter in letters {
                    answer.append(letter)
                    combination(mapping, &answer, &answers, numberIndex + 1)
                    answer.removeLast()
                }
            }
        }
    }
}
