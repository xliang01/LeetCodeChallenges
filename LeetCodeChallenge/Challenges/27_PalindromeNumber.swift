//
//  27_PalindromeNumber.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 4/13/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class PalinedromeNumber: Runnable {
    func runTests() {
        let solution1 = SolutionRecursive()
//        print(solution1.isPalindrome(1))
//        print(solution1.isPalindrome(10))
//        print(solution1.isPalindrome(11))
        print(solution1.isPalindrome(1221))
    }
    
    private class SolutionString {
        /*
            10          1010
            11          1011
            21         11001
            22         11010
            33         100001
            44         101100
           111         1101111
           121         1111001
           252         11111100
         
            Observations:
         
            All numbers between 0 and 10 are palindrome numbers
            All odd numbers have even 1s
            All even numbers have odd 1s
         */
        func isPalindrome(_ x: Int) -> Bool {
            if x < 0 {
                return false
            }
            else if x < 10 && x >= 0 {
                return true
            }
            let string = "\(x)"
            let characters = Array<Character>(string)
            for i in (0..<characters.count/2) {
                if characters[i] != characters[characters.count - 1 - i] {
                    return false
                }
            }
            return true
        }
    }
    
    private class SolutionIterative {
        /**
            Solution:
         
            For a number, figure out how many 10s are there. Use this "div" property to calculate the remainder and the multiple.
            If both the remainder and the multiple are the same, we are good. Then shrink the number down and get rid of its outer digits
            by using MOD to get rid of the left number, and /10 to get rid of the right. For example:
         
            1. Determine that "div" is 1000.
            2. 1221. 1221 % 1000 = 1. 1221 / 1000 = 1. Result 1 == 1.
            3. x = (x % div) / 10 = (1221 % 1000) / 10 = 221 / 10 = 22
            4. div = div / 100 = 1000 / 100 = 10
            5. 22 % 10 = 1. 22 % 10 = 1. Result 1 == 1.
            6. x = (x % div) / 10 = (22 % 10) / 10 = 2 / 10 = 0
            7. Break from loop
            8. Return true.
         
            Performance:
         
            Time Complexity: O(N/2) = O(N) as you must half the value each time to get rid of the outer numbers.
            Space Complexity: O(1) because no new data structures are created.
         */
        func isPalindrome(_ x: Int) -> Bool {
            if x < 0 {
                return false
            }
            else if x < 10 {
                return true
            }
            
            var x = x
            var div = 1
            while x / div >= 10 {
                div *= 10
            }
            
            while x != 0 {
                // Split the number by 10 to get the left side
                let multiple = x / div
                // Mod the number to get the right side
                let remainder = x % 10
                
                if remainder != multiple {
                    return false
                }
                // Splits the number and gets rid of the external values!! % Will strip the left side. Divide 10 strips the right side.
                x = (x % div) / 10
                div /= 100
            }
            
            return true
        }
    }
    
    private class SolutionRecursive {
        func isPalindrome(_ x: Int) -> Bool {
            var dup = x
            return isPalindrome(x, &dup)
        }
        
        func isPalindrome(_ x: Int, _ dup: inout Int) -> Bool {
            // If this is a negative, return.
            if x < 0 {
                return false
            }
            // If this is between a range, see if the outer values match.
            if x >= 0 && x < 10 {
                return x == dup % 10
            }
            // If it's not a palindrome, just return false.
            if !isPalindrome(x / 10, &dup) {
                return false
            }
            // If the inner palindrome checks out, remove the right side of the dup to compare against the original number.
            // This shrinks dup and "reverse" checks the other value up the stack.
            dup /= 10
            
            return x % 10 == dup % 10
        }
    }
}

