//
//  URLify.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/27/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class URLify: Runnable {
    func runTests() {
        let string1 = "Mr John Smith    "
        let string2 = "      "
        let string3 = ""
        
        let solution = SolutionPtr()
        print(solution.replaceWithPercent20(string1, 13))
        print(solution.replaceWithPercent20(string2, 2))
        print(solution.replaceWithPercent20(string3, 0))
    }
    
    private class SolutionPtr {
        func replaceWithPercent20(_ string: String, _ trueLength: Int) -> String {
            guard !string.isEmpty else { return string }
            guard string.count < string.count + 3 else { return string }
            
            var chars = Array<Character>(string)
            var lastIdx = chars.count - 1
            var stringIdx = trueLength - 1
            
            while stringIdx >= 0 && lastIdx >= 0 {
                if chars[stringIdx] != " " {
                    chars[lastIdx] = chars[stringIdx]
                    lastIdx -= 1
                }
                else {
                    chars[lastIdx] = "0"
                    chars[lastIdx-1] = "2"
                    chars[lastIdx-2] = "%"
                    lastIdx -= 3
                }
                stringIdx -= 1
            }
            return String(chars)
        }
    }
}
