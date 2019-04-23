//
//  4_JewelsAndStones.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 3/19/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation
/*
     You're given strings J representing the types of stones that are jewels, and S representing the stones you have.  Each character in S is a type of stone you have.  You want to know how many of the stones you have are also jewels.
 
     The letters in J are guaranteed distinct, and all characters in J and S are letters. Letters are case sensitive, so "a" is considered a different type of stone from "A".
 
     Example 1:
 
     Input: J = "aA", S = "aAAbbbb"
     Output: 3
 
     Example 2:
 
     Input: J = "z", S = "ZZ"
     Output: 0
     Note:
 
     S and J will consist of letters and have length at most 50.
     The characters in J are distinct.
*/

class JewelsAndStones: Runnable {
    func runTests() {
        print("\nSolution 1: Set with character match")
        let solution1 = SolutionSet()
        print(solution1.numJewelsInStones("aA", "aAAbbbb"))
        print(solution1.numJewelsInStones("z", "ZZ"))
        
        print("\nSolution 2: Array with Ascii code")
        let solution2 = SolutionCharacterArray()
        print(solution2.numJewelsInStones("aA", "aAAbbbb"))
        print(solution2.numJewelsInStones("z", "ZZ"))
    }
    
    private class SolutionSet {
        func numJewelsInStones(_ J: String, _ S: String) -> Int {
            let jewelTypes = Array<Character>(J).reduce(Set<Character>()) { (jewelTypes, jewel) -> Set<Character> in
                var jewelTypes = jewelTypes
                jewelTypes.insert(jewel)
                return jewelTypes
            }
            
            var count = 0
            Array<Character>(S).forEach { (stone) in
                if jewelTypes.contains(stone) {
                    count += 1
                }
            }
            
            return count
        }
    }
    
    private class SolutionCharacterArray {
        /**
         This solution uses ASCII codes to look up valid stones. Since there are only 256 unique ASCII codes,
         the lookup is much faster than using a Set or Hash. Referencing an index of an array is faster
         than querying the keys of a hash, even though both operations are O(1).
         
         Time Complexity: O(N) - Because you'll have to iterate through all of S.
         Space Complexity: O(1) - Because the ASCII array of 256 items does not change in size.
         */
        func numJewelsInStones(_ J: String, _ S: String) -> Int {
            var count = 0
            // Since jewels and stones are all characters, we can convert the jewel characters to ASCII.
            
            // Create an initial array of 256 so all ASCII values are represented.
            var asciiList = [Int](repeating: 0, count: 256)
            
            // For each jewel, mark the ascii value of the jewel as 1. All other ascii characters are 0.
            Array<Character>(J).forEach { (jewel) in
                let asciiCode = Int(jewel.unicodeScalars.first!.value)
                asciiList[asciiCode] = 1
            }
            
            /*
             For each stone, convert the value to ASCII and see if the value of the ASCII value is 1.
             If it 1, it's a valid jewel and increment the count. If it's not 1, it's not valid.
             */
            Array<Character>(S).forEach { (stone) in
                let asciiCode = Int(stone.unicodeScalars.first!.value)
                if (asciiList[asciiCode] == 1) {
                    count += 1
                }
            }
            
            return count
        }
    }
    

}
