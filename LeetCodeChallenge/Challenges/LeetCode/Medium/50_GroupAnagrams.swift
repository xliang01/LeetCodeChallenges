//
//  50_GroupAnagrams.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 5/29/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class GroupAnagrams: Runnable {
    func runTests() {
        let solution1 = SolutionHashMap()
        print(solution1.groupAnagrams(["eat", "tea", "tan", "ate", "nat", "bat"]))
        
        let solution2 = SolutionSort()
        print(solution2.groupAnagrams(["eat", "tea", "tan", "ate", "nat", "bat"]))
    }
    
    class SolutionHashCode {
        func groupAnagrams(_ strs: [String]) -> [[String]] {
            var hash = [String: [String]]()
            for s in strs {
                let key = convertToKey(s)
                hash[key, default: [String]()].append(s)
            }
            var ans = [[String]]()
            for (_ , array) in hash {
                ans.append(array)
            }
            return ans
        }
        
        private func convertToKey(_ s: String) -> String {
            var charCount = [Int](repeating: 0, count: 26)
            let chars = Array<Character>(s)
            
            for c in chars {
                charCount[Int(c.asciiValue!) - Int(Character("a").asciiValue!)] += 1
            }
            var key = [String]()
            for i in 0..<26 {
                if charCount[i] != 0 {
                    key.append("\(i)-\(charCount[i])")
                }
            }
            return key.joined(separator: ":")
        }
    }
    
    class SolutionSort {
        /**
            Solution: Sort each anagram string, and use the sorted value as a key in the hashmap. Then use the hashmap
            to store the array that will group all other anagrams.
         
            Time Complexity: O(Mlog(M) * N) where M is the length of the string, and N is the number of strings.
            Space Complexity: O(M * N) + N where N is the number of sorted keys and its length, plus the arrays that hold the strings.
        */
        func groupAnagrams(_ strs: [String]) -> [[String]] {
            var anagramMap = [String: [String]]()
            for str in strs {
                let value = String(str.sorted())
                if anagramMap[value] == nil {
                    anagramMap[value] = []
                }
                anagramMap[value]?.append(str)
            }
            return anagramMap.reduce([[String]]()) { (array, map) -> [[String]] in
                var array = array
                array.append(map.value)
                return array
            }
        }
    }
    
    class SolutionHashMap {
        func groupAnagrams(_ strs: [String]) -> [[String]] {
            var anagramMap = [String: [String]]()
            
            for str in strs {
                let key = convertStringToAnagramKey(str)
                if var grouping = anagramMap[key] {
                    grouping.append(str)
                    anagramMap[key] = grouping
                }
                else {
                    anagramMap[key] = [str]
                }
            }
            
            return anagramMap.reduce([[String]]()) { (array, map) -> [[String]] in
                var array = array
                array.append(map.value)
                return array
            }
        }
        
        private func convertStringToAnagramKey(_ str: String) -> String {
            let characters = Array<Character>(str)
            var countMap = characters.reduce([Character: Int]()) { (map, character) -> [Character: Int] in
                var map = map
                if let count = map[character] { map[character] = count + 1 }
                else { map[character] = 1 }
                return map
            }
            
            var key = ""
            for character in countMap.keys.sorted() { key += "\(character)\(countMap[character]!)" }
            return key
        }
    }
}
