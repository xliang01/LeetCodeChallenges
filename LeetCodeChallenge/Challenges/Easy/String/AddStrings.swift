//
//  AddStrings.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/22/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class AddStrings: Runnable {
    func runTests() {
        let solution = SolutionStringConvert()
        print(solution.addStrings("98", "9"))
    }
    
    private class SolutionStringConvert {
        func addStrings(_ num1: String, _ num2: String) -> String {
            var num1Unicodes: [UnicodeScalar] = Array(num1.unicodeScalars.reversed())
            var num2Unicodes: [UnicodeScalar] = Array(num2.unicodeScalars.reversed())
            var string = ""
            var index = 0
            var carry = 0
            
            while index < num1Unicodes.count || index < num2Unicodes.count {
                var n1 = 0
                var n2 = 0
                
                if index < num1Unicodes.count {
                    n1 = Int(num1Unicodes[index].value) - Int("0".unicodeScalars.first!.value)
                }
                if index < num2Unicodes.count {
                    n2 = Int(num2Unicodes[index].value) - Int("0".unicodeScalars.first!.value)
                }
                let total = n1 + n2 + carry
                string = String(total % 10) + string
                carry = total / 10
                index += 1
            }
            
            if carry > 0 {
                string = String(carry) + string
            }
            
            return string
        }
    }
}
