//
//  23_RomanToInt.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 4/6/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class RomanToInt: Runnable {
    func runTests() {
        print("Xiao Solution")
        let solution1 = SolutionFromXiao()
        print(solution1.romanToInt("III"))
        print(solution1.romanToInt("IV"))
        print(solution1.romanToInt("IX"))
        print(solution1.romanToInt("LVIII"))
        print(solution1.romanToInt("MCMXCIV"))
        
        print("Wes Solution")
        let solution2 = SolutionFromWes()
        print(solution2.romanToInt("III"))
        print(solution2.romanToInt("IV"))
        print(solution2.romanToInt("IX"))
        print(solution2.romanToInt("LVIII"))
        print(solution2.romanToInt("MCMXCIV"))
    }
    
    private class SolutionStringParse {
        func romanToInt(_ s: String) -> Int {
            return 0
        }
    }
    
    private class SolutionFromXiao {
        func romanToInt(_ s: String) -> Int {
            return 0
        }
    }
    
    private class SolutionFromWes {
        func romanToInt(_ s: String) -> Int {
            return 0
        }
    }
}
