//
//  14_DIStringMatch.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 3/24/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class DIStringMatch: Runnable {
    func runTests() {
        let solution1 = SolutionArrayIndex()
        print(solution1.diStringMatch("IDID"))
        print(solution1.diStringMatch("III"))
        print(solution1.diStringMatch("DDI"))
        
        
        let solution2 = SolutionArrayReplaceIndex()
        print(solution2.diStringMatch("IDID"))
        print(solution2.diStringMatch("III"))
        print(solution2.diStringMatch("DDI"))
        print(solution2.diStringMatch("DDD"))
        print(solution2.diStringMatch("IIDD"))
    }
    
    private class SolutionArrayIndex {
        func diStringMatch(_ S: String) -> [Int] {
            var min = 0
            var max = S.count
            var answer = [Int](repeatElement(0, count: S.count + 1))
            let characters = Array<Character>(S)
            
            for (index, character) in characters.enumerated() {
                let increase = character == "I"
                if increase {
                    answer[index] = min
                    min += 1
                }
                else {
                    answer[index] = max
                    max -= 1
                }
                if index == characters.count - 1 {
                    answer[index + 1] = increase ? min : max
                }
            }
            
            return answer
        }
    }
    
    private class SolutionArrayReplaceIndex {
        /**
            Solution:
         
            Have two properties (min and max) that start at index 0 and N respectively. These are
            incremented and decremented based on the value of the character in the input string (I or D).
         
            We convert the string to unicode characters for a faster lookup. At the very end, we append
            "min" to the end of the array. This is because because as both the min and max increment and
            decrement respectively, min will eventually converge to max + 1, which is the correct value
            for the last value.
         
            Performance:
         
            Runtime Complexity: O(N) because we must iterate through the list.
            Space Complexity: O(N) for the scalar list.
         */
        func diStringMatch(_ S: String) -> [Int] {
            var min = 0
            var max = S.count
            var asciiList = S.unicodeScalars.map { Int($0.value) }
            
            for (index, ascii) in asciiList.enumerated() {
                if ascii == 73 {
                    asciiList[index] = min
                    min += 1
                }
                else {
                    asciiList[index] = max
                    max -= 1
                }
            }
            
            asciiList.append(min)
            return asciiList
        }
    }
}
