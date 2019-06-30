//
//  StringToIntegerATOI.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/26/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class StringToIntegerATOI: Runnable {
    func runTests() {
        let solution = SolutionParse()
        print(solution.myAtoi("-1232132131232131"))
    }
    
    private class SolutionParse {
        func myAtoi(_ str: String) -> Int {
            if str.isEmpty { return 0 }
            
            var asciiZero = Int(Character("0").asciiValue!)
            var isNegative = false
            var started = false
            var result = 0
            
            for c in str {
                if c == "-" && !started {
                    isNegative = true
                    started = true
                }
                else if c == "+" && !started {
                    started = true
                }
                else {
                    let digit = Int(c.asciiValue!) - asciiZero
                    if (digit < 0 || digit > 9) {
                        if started { break }
                        else if c == " " { continue }
                        else { break }
                    }
                    else if !started {
                        started = true
                    }
                    
                    if !isNegative {
                        if (result < Int32.max / 10) || (result == Int32.max / 10 && digit <= Int32.max % 10) {
                            result = result * 10 + digit
                        }
                        else {
                            return Int(Int32.max)
                        }
                    }
                    else {
                        if (result > Int32.min / 10) || (result == Int32.min / 10 && -digit >= Int32.min % 10) {
                            result = result * 10 - digit
                        }
                        else {
                            return Int(Int32.min)
                        }
                    }
                }
            }
            return result
        }
    }
}
