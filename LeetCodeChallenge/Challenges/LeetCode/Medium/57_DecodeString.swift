//
//  57_DecodeString.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/7/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class DecodeString: Runnable {
    func runTests() {
        let solution1 = SolutionIteration()
        print(solution1.decodeString("3[a2[b]c]"))
        print(solution1.decodeString("2[abc]3[cd]ef"))
        print(solution1.decodeString("10[ab2[cd]]2[bc]"))
        print(solution1.decodeString("100[leetcode]"))
    }
    
    private class SolutionRecursion {
        func decodeString(_ s: String) -> String {
            guard !s.isEmpty else { return "" }
            let chars = Array<Character>(s)
            return decodeString(chars, nil, 0, chars.count - 1)
        }
        
        /**
            Solution:
         
            Recursively loop through the string and collect "[" or "]". If "]" is collected, stop inserting the string and find the matching "[".
            If the matching "[" is found, recursively traverse the string with the index of "[" + 1, and "]" - 1, with the count. Do the not recursve if
            no "[" or "]" is found.
         
            Once the sub string is found, insert the substring to the front of the overall string of what's already appended.
         
            Performance Analysis:
         
            Time Complexity: O(N^2): The worst case is if we have a pattern like 2[a3[b4[a5[c..k[letter]]]]]. In this case, we have to iterate through N.
            Then apply k1*N, and recursively run through k2*(N-3)... km*(N-3m) and repeat until we can no longer recurse. This means it's N + (N - 3) + (N - 6)(....
            which is eerily close to O(N + (N - 1) + (N - 2)... This results in a O(N^2) behavior.
         
            Space Complexity: The max number of recursion is roughly O(N). Each iteration has O(k)
        */
        func decodeString(_ chars: [Character], _ count: Int?, _ start: Int, _ end: Int) -> String {
            var bracketIndexStack = [Int]()
            var string = ""
            var stringIndex = end
            
            while stringIndex >= start {
                if chars[stringIndex] == "]" {
                    bracketIndexStack.append(stringIndex)
                }
                else if
                    chars[stringIndex] == "[",
                    let backIndex = bracketIndexStack.popLast(),
                    bracketIndexStack.isEmpty {
                    
                    let endIndex = stringIndex - 1
                    var currentNumIndex = endIndex
                    while Int(String(chars[currentNumIndex])) != nil {
                        currentNumIndex -= 1
                        if currentNumIndex < 0 { break }
                    }
                    let numString = Int(String(chars[currentNumIndex+1...endIndex]))!
                    string = "\(decodeString(chars, Int(numString), stringIndex+1, backIndex-1))\(string)"
                    stringIndex = currentNumIndex + 1
                }
                else if bracketIndexStack.isEmpty {
                    string = "\(String(chars[stringIndex]))\(string)"
                }
                stringIndex -= 1
            }
            
            if let count = count {
                var combinedString = ""
                for _ in 0..<count { combinedString += string }
                string = combinedString
            }
            
            return string
        }
    }
    
    private class SolutionIteration {
        func decodeString(_ s: String) -> String {
            var chars = Array<Character>(s)
            var result: String = ""
            var countStack = [Int]()
            var stringStack = [String]()
            var stringIndex = 0
            
            while stringIndex < s.count {
                if chars[stringIndex] >= "0", chars[stringIndex] <= "9" {
                    var count = 0
                    while chars[stringIndex] >= "0" && chars[stringIndex] <= "9" {
                        count = 10 * count + Int(String(chars[stringIndex]))!
                        stringIndex += 1
                    }
                    countStack.append(count)
                }
                else if chars[stringIndex] == "[" {
                    stringStack.append(result)
                    result = ""
                    stringIndex += 1
                }
                else if chars[stringIndex] == "]" {
                    if let savedCount = countStack.popLast(), var savedResult = stringStack.popLast() {
                        for _ in 0..<savedCount {
                            savedResult.append(result)
                        }
                        result = savedResult
                    }
                    stringIndex += 1
                }
                else {
                    result.append(chars[stringIndex])
                    stringIndex += 1
                }
            }
            
            return result
        }
    }
    
}
