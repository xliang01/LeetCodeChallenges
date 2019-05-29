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
    
    class SolutionSort {
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
