//
//  68_FindDuplicateFiles.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/9/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class FindDuplicateFiles: Runnable {
    func runTests() {
        let solution = SolutionHashMap()
        print(solution.findDuplicate(["root/a 1.txt(abcd) 2.txt(efgh)", "root/c 3.txt(abcd)", "root/c/d 4.txt(efgh)", "root 4.txt(efgh)"]))
        print(solution.findDuplicate(["root/a 1.txt(FB) 2.txt(a)","root/c 3.txt(Ea)","root/c/d 4.txt(b)","root 4.txt(c)"]))
    }
    
    private class SolutionHashMap {
        func findDuplicate(_ paths: [String]) -> [[String]] {
            var lookup = [String: [(String, String)]]()
            for path in paths {
                let components = path.split(separator: " ")
                let directory = String(components[0])
                
                for i in 1..<components.count {
                    let component = components[i]
                    let leftIndex = component.firstIndex(of: "(")!
                    let rightIndex = component.index(component.endIndex, offsetBy: -2)
                    let filename = String(component[..<leftIndex])
                    let content = String(component[component.index(after: leftIndex)...rightIndex])
                    
                    if lookup[content] == nil {
                        lookup[content] = []
                    }
                    lookup[content]!.append((directory, filename))
                }
            }
            var groups = [[String]]()
            let keys = lookup.keys.sorted().reversed()
            for key in keys {
                let tuple = lookup[key]!
                if tuple.count > 1 {
                    groups.append(tuple.map {"\($0)/\($1)"})
                }
            }
            return groups
        }
    }
}
