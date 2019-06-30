//
//  8_MorseCode.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 3/22/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class MorseCode: Runnable {
    func runTests() {
        let solution1 = SolutionAscii()
        print(solution1.uniqueMorseRepresentations( ["gin", "zen", "gig", "msg"]))
    }
    
    private class SolutionAscii {
        let codes = [".-",      //a
                     "-...",    //b
                     "-.-.",    //c
                     "-..",     //d
                     ".",       //e
                     "..-.",    //f
                     "--.",     //g
                     "....",    //h
                     "..",      //i
                     ".---",    //j
                     "-.-",     //k
                     ".-..",    //l
                     "--",      //m
                     "-.",      //n
                     "---",     //o
                     ".--.",    //p
                     "--.-",    //q
                     ".-.",     //r
                     "...",     //s
                     "-",       //t
                     "..-",     //u
                     "...-",    //v
                     ".--",     //w
                     "-..-",    //x
                     "-.--",    //y
                     "--.."     //z
                    ]
        
        /**
            Solution:
         
            Convert words into it's ascii equivalent and offset by 'a'. Then find the index from the array.
            Add to Set for final count.
         
            Performance:
         
            Time Complexity: O(N) - Because we have to iterate through N words.
            Space Complexity: O(N) - Because we could store up to N number of unique morse codes in the set.
         */
        func uniqueMorseRepresentations(_ words: [String]) -> Int {
            var morseCodeSet = Set<String>()
            
            words.forEach { (word) in
                var morseCode = ""
                for unicode in word.unicodeScalars {
                    let index = Int(unicode.value) - 97
                    morseCode.append(contentsOf: codes[index])
                }
                morseCodeSet.insert(morseCode)
            }
            
            return morseCodeSet.count
        }
    }
}
