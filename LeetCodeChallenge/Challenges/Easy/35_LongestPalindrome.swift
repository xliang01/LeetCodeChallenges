//
//  35_LongestPalindrome.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 5/4/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

/**
    abbaa
 
    a
    ab
    abb
    abba
    abbaa
    b
    bb
    bba
    bbaa
    ba
    baa
    a
    aa
 */

class LongestPalindrome: Runnable {
    func runTests() {
        let solution1 = SolutionDP()
        print(solution1.longestPalindrome("a"))
        print(solution1.longestPalindrome("aa"))
        print(solution1.longestPalindrome("ab"))
        print(solution1.longestPalindrome("aba"))
        print(solution1.longestPalindrome("aab"))
        print(solution1.longestPalindrome("abb"))
        print(solution1.longestPalindrome("abba"))
        print(solution1.longestPalindrome("aaba"))
        print(solution1.longestPalindrome("abaa"))
        print(solution1.longestPalindrome("abbaa"))
        print(solution1.longestPalindrome("aabba"))
    }
    
    private class SolutionBruteForce {
        /**
            Runtime O(N^3)
         */
        func longestPalindrome(_ s: String) -> String {
            guard s.count > 1 else { return s }
            var longestPalindrome = String(s.first!)
            
            let characters = Array<Character>(s)
            for i in (0..<characters.count) {
                var subString = String(characters[i])
                for j in (i+1..<characters.count) {
                    subString += "\(characters[j])"
                    if isPanlidrome(characters: Array<Character>(subString)) && subString.count > longestPalindrome.count {
                        longestPalindrome = subString
                    }
                }
            }
            return longestPalindrome
        }
        
        private func isPanlidrome(characters: [Character]) -> Bool {
            for i in (0..<characters.count/2) {
                if characters[i] != characters[characters.count-1-i] {
                    return false
                }
            }
            return true
        }
    }
    
    private class SolutionDP {
        /**
            This solution uses the bottom up dynamic programming concept to store all combinations of a substring
            into a lookup table. If it is a palindrome, the lookup table at those indices are marked true. Otherwise,
            it's default to false. We then go through every string combination and fill up the table with base cases
            1 and 2 strings. Then for 3 strings or above, we simply iterate through the string and see if the substrings
            are palindromes using the table lookup. If it is, AND if the outer string is a palindrome, then we know that
            this entire new substring is a palindrome.
         
            Performance:
         
            Time Complexity: O(N^2) to loop through every combination of string. Better than brute force O(N^3)
            Space Complexity: O(N^2) for the lookup table.
         */
        func longestPalindrome(_ s: String) -> String {
            guard s.count > 1 else { return String(s.first!) }
            
            let n = s.count
            let characters = Array<Character>(s)
            var lookup = [[Bool]](repeating: [Bool](repeating: false, count: n), count: n)
            
            var start = 0
            var maxLength = 1
            // Single letters are always palindromes.
            for i in (0..<n) {
                lookup[i][i] = true
            }
            
            // Double letters are always palindromes.
            for i in (0..<n - 1) {
                if characters[i] == characters[i+1] {
                    lookup[i][i+1] = true
                    start = i
                    maxLength = 2
                }
            }
            
            if n > 2 {
            //Example abbaa n = 5. check = 4. stop at 3. n - k
                for stringCheckLength in (3...n) {
                    for i in (0..<n-stringCheckLength + 1) {
                        // Get the max bound to check. This will go from i to k. K will increment to check for larger strings.
                        let k = i + stringCheckLength - 1
                        // Bottom up approach to check if the previous combination between the letters are palindromes.
                        if characters[i] == characters[k] && lookup[i + 1][k - 1] && stringCheckLength > maxLength {
                            start = i
                            maxLength = stringCheckLength
                            lookup[i][k] = true
                        }
                    }
                }
            }
            
            let startIndex = s.index(s.startIndex, offsetBy: start)
            let endIndex = s.index(startIndex, offsetBy: maxLength)
            return String(s[startIndex..<endIndex])
        }
    }
    
    private class SolutionRecursive {
        func longestPalindrome(_ s: String) -> String {
            guard !s.isEmpty else { return "" }
            
            let characters = Array<Character>(s)
            var palindrome = String(characters[0])
            var palindromeLength = 1
            longest(characters, characters.count, &palindrome, &palindromeLength)
            return palindrome
        }
        
        func longest(_ characters: [Character], _ n: Int, _ palindrome: inout String, _ palindromeLength: inout Int) {
            if n == 1 { return }
            let pivot = n/2
            var i = pivot
            let even = n % 2 == 0
            
            while i < n {
                let left = i - 1
                let right = even ? i : i + 1
                if characters[left] == characters[right] {
                    let length = right - left + 1
                    if length > palindromeLength {
                        palindromeLength = length
                        palindrome = String(characters[left...right])
                    }
                    i += 1
                    if i == n - 1 { return }
                }
                else {
                    let endIndex = even ? pivot - 1 : pivot
                    let leftCharacters = Array(characters[0...endIndex])
                    let rightCharacters = Array(characters[pivot...n-1])
                    longest(leftCharacters, (n + 1)/2, &palindrome, &palindromeLength)
                    longest(rightCharacters, (n + 1)/2, &palindrome, &palindromeLength)
                    return
                }
            }
        }
    }
}
