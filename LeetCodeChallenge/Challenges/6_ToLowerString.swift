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
        let solution1 = SolutionShiftASCII()
        print(solution1.toLowerCase("Hello"))
        print(solution1.toLowerCase("hello"))
        print(solution1.toLowerCase("LOVELY"))
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
}
