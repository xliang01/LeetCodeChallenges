//
//  48_StringPermutations.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 5/27/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

// Theory right here: https://www.youtube.com/watch?v=GCm7m5671Ps
class StringPermutations: Runnable {
    func runTests() {
        let solution1 = SolutionBackTrack()
        solution1.printPermutations("abc")
    }
    
    private class SolutionBackTrack {
        func printPermutations(_ string: String) {
            var characters = Array<Character>(string)
            printPermutations(&characters, 0, characters.count - 1)
        }
        
        private func printPermutations(_ characters: inout [Character], _ left: Int, _ right: Int) {
            if left == right {
                print(String(characters))
                return
            }
            for i in (left...right) {
                // This is where we shift the characters to ensure this level has all of the combinations available.
                swap(&characters, left, i)
                // Recurse with the fixed character swapped on the left.
                printPermutations(&characters, left + 1, right)
                // Back track here to return to the original state before we go into the recursion again.
                swap(&characters, left, i)
            }
        }
        
        private func swap(_ characters: inout [Character], _ left: Int, _ right: Int) {
            let temp = characters[left]
            characters[left] = characters[right]
            characters[right] = temp
        }
    }
}
