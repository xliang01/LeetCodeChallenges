//
//  48_SortLog.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 5/23/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class SortLog: Runnable {
    func runTests() {
        let solution1 = Solution1()
        print(solution1.reorderLogFiles(["a1 9 2 3 1","g1 act car","zo4 4 7","ab1 off key dog","a8 act zoo"]))
    }
    
    private class Solution1 {
        private struct Log {
            let id: String
            let value: String
            let log: String
            init(_ log: String) {
                let index = log.firstIndex(of: " ")!
                id = String(log[..<index])
                value = String(log[index...])
                self.log = log
            }
        }
        
        func reorderLogFiles(_ logs: [String]) -> [String] {
            var numericLogs = [String]()
            var stringLogs = [Log]()
            
            for log in logs {
                if isNumericLog(log: log) {
                    numericLogs.append(log)
                }
                else {
                    stringLogs.append(Log(log))
                }
            }
            
            return sort(logs: stringLogs).map { $0.log } + numericLogs
        }
        
        private func isNumericLog(log: String) -> Bool {
            return Int(String(log.split(separator: " ")[1].first!)) != nil
        }
        
        private func sort(logs: [Log]) -> [Log] {
            return logs.sorted(by: { (left, right) -> Bool in
                if left.value <= right.value {
                    return true
                }
                else if left.value == right.value {
                    return left.id < right.id
                }
                else {
                    return false
                }
            })
        }
    }
}
