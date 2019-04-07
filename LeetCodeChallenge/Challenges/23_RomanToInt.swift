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
        let solution1 = SolutionFromXiaoReverseLookup()
        print(solution1.romanToInt("III"))
        print(solution1.romanToInt("IV"))
        print(solution1.romanToInt("IX"))
        print(solution1.romanToInt("LVIII"))
        print(solution1.romanToInt("MCMXCIV"))
        print(solution1.romanToInt("MCDLXXVI"))
        
//        print("Wes Solution")
//        let solution2 = SolutionFromWes()
//        print(solution2.romanToInt("III"))
//        print(solution2.romanToInt("IV"))
//        print(solution2.romanToInt("IX"))
//        print(solution2.romanToInt("LVIII"))
//        print(solution2.romanToInt("MCMXCIV"))
    }
    
    private class SolutionStringParse {
        func romanToInt(_ s: String) -> Int {
            return 0
        }
    }

    /**
         I
         II
         IV
         XIV
         XVI
         XVII
         CMIV
     */
    // "MCDLXXVI"
    private class SolutionFromXiaoReverseLookup {
        let romanValues = [Character("I"): 1,
                           Character("V"): 5,
                           Character("X"): 10,
                           Character("L"): 50,
                           Character("C"): 100,
                           Character("D"): 500,
                           Character("M"): 1000]
        func romanToInt(_ s: String) -> Int {
            var sum = 0
            var currentIndex = s.count - 1
            let characters = Array<Character>(s)
            
            while currentIndex >= 0 {
                let previousIndex = currentIndex - 1
                
                let currValue = romanValues[characters[currentIndex]]!
                sum += currValue
                
                if previousIndex >= 0 {
                    let prevValue = romanValues[characters[previousIndex]]!
                    if prevValue < currValue {
                        sum -= prevValue
                        currentIndex -= 1
                    }
                }
                currentIndex -= 1
            }
            
            return sum
        }
    }
    
    private class SolutionFromWes {
        func romanToInt(_ s: String) -> Int {
            return 0
        }
    }
}
