//
//  GoatLatin.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/30/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class GoatLatin: Runnable {
    func runTests() {
        let solution = SolutionArray()
        print(solution.toGoatLatin("I speak Goat Latin"))
        print(solution.toGoatLatin("The quick brown fox jumped over the lazy dog"))
    }
    
    private class SolutionArray {
        func toGoatLatin(_ S: String) -> String {
            let vows = Set<Character>(["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"])
            var ans = [Character]()
            let chars = Array<Character>(S)
            let ma: [Character] = ["m", "a"]
            var suffix: [Character] = ["a"]
            var startIdx = 0
            
            while startIdx < chars.count {
                if vows.contains(chars[startIdx]) {
                    while startIdx < chars.count, chars[startIdx] != " " {
                        ans.append(chars[startIdx])
                        startIdx += 1
                    }
                }
                else {
                    let startLetter = chars[startIdx]
                    startIdx += 1
                    while startIdx < chars.count, chars[startIdx] != " " {
                        ans.append(chars[startIdx])
                        startIdx += 1
                    }
                    ans.append(startLetter)
                }
                
                ans.append(contentsOf: ma)
                ans.append(contentsOf: suffix)
                ans.append(" ")
                suffix.append("a")
                startIdx += 1
            }
            
            ans.removeLast()
            return String(ans)
        }
    }
}
