//
//  6_ToLowerString.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 3/20/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class ToLowerString: Runnable {
    func runTests() {
        print("Solution 1: Shift ASCII")
        let solution1 = SolutionShiftASCII()
        print(solution1.toLowerCase("Hello"))
        print(solution1.toLowerCase("hello"))
        print(solution1.toLowerCase("LOVELY"))
        
        print("\nSolution 2: Shift ASCII with numeric constants")
        let solution2 = SolutionShiftASCIIConst()
        print(solution2.toLowerCase("Hello"))
        print(solution2.toLowerCase("hello"))
        print(solution2.toLowerCase("LOVELY"))
        
        print("\nSolution 3: Shift ASCII with bytes")
        let solution3 = SolutionBytes()
        print(solution3.toLowerCase("Hello"))
        print(solution3.toLowerCase("hello"))
        print(solution3.toLowerCase("LOVELY"))
    }
    
    private class SolutionShiftASCII {
        static let asciia = Character("a").unicodeScalars.first!.value
        static let asciiA = Character("A").unicodeScalars.first!.value
        static let asciiZ = Character("Z").unicodeScalars.first!.value
        static let shift = Int(asciiA) - Int(asciia)
        
        func toLowerCase(_ str: String) -> String {
            var characters = Array<Character>()
            Array<Character>(str).forEach { (character) in
                let asciiValue = character.unicodeScalars.first!.value
                
                if asciiValue >= SolutionShiftASCII.asciiA, asciiValue <= SolutionShiftASCII.asciiZ {
                    let lowerCaseAscii = Int(asciiValue) - SolutionShiftASCII.shift
                    if let unicode = UnicodeScalar(lowerCaseAscii) {
                        characters.append(Character(unicode))
                    }
                }
                else {
                    characters.append(character)
                }
            }
            return String(characters)
        }
    }
    
    private class SolutionShiftASCIIConst {
        /**
            Solution: Uses direct ASCII values for calculation and shifting.
         
            Performance:
         
            Time Complexity: O(N) to iterate through the entire character list.
            Space Complexity: O(N) to store the entire string.
         */
        func toLowerCase(_ str: String) -> String {
            // Get character array from the String.
            var characterArray = Array<Character>(str)
            // Enumerate with the character and index.
            for (index, character) in characterArray.enumerated() {
                let asciiValue = Int(character.unicodeScalars.first!.value)
                // Ensure the ASCII value is within the range of capital letters.
                if
                    // 65 = A
                    asciiValue >= 65,
                    // 90 = B
                    asciiValue <= 90,
                    // Shift by 32 to lower the case.
                    let unicode = UnicodeScalar(asciiValue + 32) {
                    // Replace only the character affected at the index.
                    characterArray[index] = Character(unicode)
                }
            }
            return String(characterArray)
        }
    }
    
    private class SolutionBytes {
        /**
             Solution: Uses direct ASCII values for calculation and shifting.
         
             Performance:
         
             Time Complexity: O(N) to iterate through the entire character list.
             Space Complexity: O(N) to store the entire string.
         */
        func toLowerCase(_ str: String) -> String {
            // Covert to bytes.
            var bytes = Array(str.utf8)
            // Enumerate with the character and index.
            for (index, asciiValue) in bytes.enumerated() {
                // Ensure the ASCII value is within the range of capital letters.
                if
                    // 65 = A
                    asciiValue >= 65,
                    // 90 = B
                    asciiValue <= 90 {
                    // Replace only the character affected at the index.
                    bytes[index] = asciiValue + 32
                }
            }
            return String(bytes: bytes, encoding: .utf8)!
        }
    }
}
