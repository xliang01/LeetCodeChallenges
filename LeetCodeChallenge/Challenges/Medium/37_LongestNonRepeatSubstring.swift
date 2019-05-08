//
//  37_LongestNonRepeatSubstring.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 5/6/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class LongestNonRepeatSubstring: Runnable {
    func runTests() {
        let solution1 = SolutionSlidingSlidingWindowHash()
        print(solution1.lengthOfLongestSubstring("ab"))
        print(solution1.lengthOfLongestSubstring("abcabcbb"))
        print(solution1.lengthOfLongestSubstring("bbbbb"))
        print(solution1.lengthOfLongestSubstring("pwwkew"))
    }
    
    private class SolutionSlidingSlidingWindowHash {
        func lengthOfLongestSubstring(_ s: String) -> Int {
            let characters = Array<Character>(s)
            let n = characters.count
            var i = 0
            var answer = 0
            var cache = [Character: Int]()
            
            for j in (0..<n) {
                let character = characters[j]
                if let index = cache[character] {
                    i = max(index, i)
                }
                answer = max(answer, j - i + 1)
                // j + 1 is to calculate the next index for i. Therefore, i is the index where the next unique substring is.
                cache[character] = j + 1
            }
            return answer
        }
    }
    
    private class SolutionSlidingSlidingWindow {
        func lengthOfLongestSubstring(_ s: String) -> Int {
            let characters = Array<Character>(s)
            let n = characters.count
            var i = 0
            var j = 0
            var answer = 0
            var cache = Set<Character>()
            
            while i < n && j < n {
                if !cache.contains(characters[j]) {
                    cache.insert(characters[j])
                    j += 1
                    answer = max(answer, j - i)
                }
                else {
                    cache.remove(characters[i])
                    i += 1
                }
            }
            
            return answer
        }
    }
    
    private class SolutionDPBottomUp {
        func lengthOfLongestSubstring(_ s: String) -> Int {
            guard !s.isEmpty else { return 0}
            guard s.count > 1 else { return 1 }
            let characters = Array<Character>(s)
            let n = characters.count
            var lookup = [[Bool]](repeating: [Bool](repeating: false, count: n+1), count: n+1)
            
            var max = 1
            // Base case. All lookups with a length of 1 is true since the longest substring of length 1 will always be true.
            for i in (0..<n) {
               lookup[i][1] = true
            }
            
            // If we have more than 1, build up the lookup table from bottom up.
            if n > 1 {
                /*
                    We look for the substring length from 2 to n. For example of this string pwwkew:
                 
                    At subLength = 2, we look at the following combinations:
                 
                        i = 0: pw
                        i = 1: ww  x
                        i = 2: wk
                        i = 3: ke
                        i = 4: ew
                 
                    Index i at 1 is a duplicate. Therefore, this combination cannot be considered for the max length.
                 
                    At subLength = 3, we look at the following combinations:
                 
                        i = 0: pww  x
                        i = 1: wwk  x
                        i = 2: wke
                        i = 3: kew
                 
                    Index at 0 and 1 are invalid. We can see "ww" is present in both combinations. Also, "ww" can be referenced
                    from the previous index i of 1 at subLength 2. Knowing this pattern, we can build a cache table that stores
                    the combination of index i, and subLength k as lookup for the previous max subLength.
                 
                    Lookup[N][N], where the previous look up is Lookup[i+1][k-1] and Lookup[i][k-1].
                 
                    Both these lookups must be true AND the outer strings must not equal each other as a new letter is introduced.
                */
                for subLength in 2...n {
                    for left in 0..<(n - subLength + 1) {
                        let right = left + subLength - 1
                        if characters[left] != characters[right] && lookup[left+1][subLength-1] && lookup[left][subLength-1] {
                            lookup[left][subLength] = true
                            max = subLength
                        }
                    }
                }
            }
            
            return max
        }
    }
    
    /*
    private class SolutionDPBottomUp {
        func lengthOfLongestSubstring(_ s: String) -> Int {
            guard !s.isEmpty else { return 0}
            guard s.count > 1 else { return 1 }

            let characters = Array<Character>(s)
            let n = characters.count
            
            var repeatedIndex = Set<Int>()
            var max = 1

            // Base case to check if any string index has repeating characters
            for i in (0..<n-1) {
                if characters[i] == characters[i+1] { repeatedIndex.insert(i+1) }
                else { max = 2 }
            }
            
            if n > 2 {
                for k in (3...n) {
                    for i in (0..<n-k+1) {
                        let endIndex = i+k-1
                        if repeatedIndex.contains(endIndex) { continue }
                        else if characters[i] == characters[endIndex] || repeatedIndex.contains(endIndex - 1) { repeatedIndex.insert(endIndex) }
                        else if !repeatedIndex.contains(endIndex) { max = k }
                    }
                }
            }
            
            return max
        }
    }
     */
}
