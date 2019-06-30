//
//  CountAndSay.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/23/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class CountAndSay: Runnable {
    func runTests() {
        let solution1 = SolutionHashmap()
        print(solution1.countAndSay(4))
        
        let solution2 = SolutionIteration()
        print(solution2.countAndSay(2))
    }
    
    private class SolutionIteration {
        func countAndSay(_ n: Int) -> String {
            if n == 1 { return "1" }
            var prevString = "1"
            var currentString = ""
            var count = 1
            var charToMatch = prevString.first!
            
            for _ in 1..<n {
                let prevChars = Array<Character>(prevString)
                charToMatch = prevString.first!
                currentString = ""
                count = 0
                
                for char in prevChars {
                    if char == charToMatch {
                        count += 1
                    }
                    else {
                        currentString += "\(count)\(charToMatch)"
                        charToMatch = char
                        count = 1
                    }
                }
                currentString += "\(count)\(charToMatch)"
                prevString = currentString
            }
            
            return currentString
        }
    }
    
    private class SolutionHashmap {
        func countAndSay(_ n: Int) -> String {
            var numberList: [Int] = [1]
            for i in 1..<n {
                numberList = getCountAndSay(numberList)
            }
            
            var answer = ""
            for num in numberList {
                answer = answer + String(num)
            }
            return answer
        }
        
        private func getCountAndSay(_ values: [Int]) -> [Int] {
            var map = [Int: Int]()
            var output = [Int]()
            
            for val in values {
                if map[val] == nil {
                    if !map.isEmpty {
                        for (value, count) in map {
                            output.append(contentsOf: [count, value])
                        }
                        map.removeAll()
                    }
                    map[val] = 1
                }
                else {
                    map[val] = map[val]! + 1
                }
            }
            
            if !map.isEmpty {
                for (value, count) in map {
                    output.append(contentsOf: [count, value])
                }
            }
            
            return output
        }
    }
}
