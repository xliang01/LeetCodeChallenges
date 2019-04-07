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
        print("Xiao's Solution")
        let solution1 = SolutionFromXiaoReverseLookup()
        print(solution1.romanToInt("III"))
        print(solution1.romanToInt("IV"))
        print(solution1.romanToInt("IX"))
        print(solution1.romanToInt("LVIII"))
        print(solution1.romanToInt("MCMXCIV"))
        print(solution1.romanToInt("MCDLXXVI"))
        print(solution1.romanToInt("CMIV"))
        
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
        Examples of special case.
     
         I
         VI
         IV
         XVI
         XIV
         XVII
         CMIV
     */
    private class SolutionFromXiaoReverseLookup {
        let romanValues = [Character("I"): 1,
                           Character("V"): 5,
                           Character("X"): 10,
                           Character("L"): 50,
                           Character("C"): 100,
                           Character("D"): 500,
                           Character("M"): 1000]
        /**
            Solution:
         
            Iterate backwards with the current value, and the previous (look behind) value. If the look behind
            value is less that the current value, subtract the look behind value from the current value. Then decrease
            the current index by 2 in order to move past subtracted value. Otherwise, if the look behind value is
            greater than the current value, just keep accumulating the current value.
         
            Performance:
         
            Time Complexity: O(N) for the number of characters in the string that must be iterated.
            Space Complexity: O(N) for converting a string into a list of characters.
         */
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
    
    private class SolutionFromXiaoReverseLookupWithIntArray {
        func romanLetterToInt(_ ch: Character) -> Int {
            switch (ch) {
            case "I":
                return 1
            case "V":
                return 5
            case "X":
                return 10
            case "L":
                return 50
            case "C":
                return 100
            case "D":
                return 500
            case "M":
                return 1000
            default:
                return -1
            }
        }
        
        /**
            Solution:

            Iterate backwards with the current value, and the previous (look behind) value. If the look behind
            value is less that the current value, subtract the look behind value from the current value. Then decrease
            the current index by 2 in order to move past subtracted value. Otherwise, if the look behind value is
            greater than the current value, just keep accumulating the current value.

            Performance:

            Time Complexity: O(N) for the number of characters in the string that must be iterated.
            Space Complexity: O(N) for converting a string into a list of characters.
         */
        func romanToInt(_ s: String) -> Int {
            var sum = 0
            var currentIndex = s.count - 1
            let characters = Array<Character>(s)
            
            while currentIndex >= 0 {
                let previousIndex = currentIndex - 1
                
                let currValue = romanLetterToInt(characters[currentIndex])
                sum += currValue
                
                if previousIndex >= 0 {
                    let prevValue = romanLetterToInt(characters[previousIndex])
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
