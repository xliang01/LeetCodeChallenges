//
//  20_FizzBuzz.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 3/28/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class FizzBuzz: Runnable {
    func runTests() {
        let solution1 = SolutionMod()
        print(solution1.fizzBuzz(15))
        
        
        let solution2 = SolutionHash()
        print(solution2.fizzBuzz(15))
    }
    
    private class SolutionMod {
        func fizzBuzz(_ n: Int) -> [String] {
            var output = [String](repeating: "", count: n)

            for i in (1...n) {
                let isDivisibleByThree = i % 3 == 0
                let isDivisibleByFive = i % 5 == 0

                var value = "\(i)"
                if isDivisibleByThree {
                    value = "Fizz"
                }
                if isDivisibleByFive {
                    value = isDivisibleByThree ? value + "Buzz" : "Buzz"
                }

                output[i - 1] = value
            }

            return output
        }
    }
    
    private class SolutionHash {
        private let dictionary = [3: "Fizz", 5: "Buzz"]
        private lazy var keys = dictionary.keys.sorted()
        
        /**
            Solution:
         
            Given N, reference i in hashmap D to ensure i % key == 0 (read i MOD key equals zero). If it is true, the number is divisible.
         
            Performance:
         
            Time Complexity: O(N) because we have to loop N times to get the final result.
            Space Complexity: O(N) because we have to append N items in an array.
         */
        func fizzBuzz(_ n: Int) -> [String] {
            var output = [String]()
            for i in (1...n) {
                var value = ""
                for key in keys {
                    if i % key == 0 {
                        value += dictionary[key]!
                    }
                }
                if value.isEmpty {
                    output.append("\(i)")
                }
                else {
                    output.append(value)
                }
            }
            
            return output
        }
    }
}
