//
//  LoggerRateLimiter.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/31/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class LoggerRateLimiter: Runnable {
    func runTests() {
        let logger = LoggerQueue()
        print(logger.shouldPrintMessage(100, "bug"))
        print(logger.shouldPrintMessage(110, "bug"))
    }
    
    private class LoggerMap {
        private var logMap = [String: Int]()
        
        init() { }
        
        /** Returns true if the message should be printed in the given timestamp, otherwise returns false.
         If this method returns false, the message will not be printed.
         The timestamp is in seconds granularity. */
        func shouldPrintMessage(_ timestamp: Int, _ message: String) -> Bool {
            if let mt = logMap[message], timestamp - mt >= 10 {
                logMap[message] = timestamp
                return true
            }
            else if logMap[message] == nil {
                logMap[message] = timestamp
                return true
            }
            return false
        }
    }
    
    /**
        T: O(N)
    */
    private class LoggerQueue {
        private class Log {
            let time: Int
            private var messages = Set<String>()
            
            init(time: Int,
                 message: String) {
                self.time = time
                messages.insert(message)
            }
            
            func hasMessage(_ message: String) -> Bool {
                return messages.contains(message)
            }
            
            func insertMessage(_ message: String) {
                messages.insert(message)
            }
        }
        
        private var queue = LinkedList<Log>()
        
        init() { }
        
        /** Returns true if the message should be printed in the given timestamp, otherwise returns false.
         If this method returns false, the message will not be printed.
         The timestamp is in seconds granularity. */
        func shouldPrintMessage(_ timestamp: Int, _ message: String) -> Bool {
            // Remove all logs that are greater than 10 second sago
            var curr = queue.head
            while curr != nil {
                let log = curr!.value
                let time = log.time
                
                curr = curr?.next
                if timestamp - time >= 10 {
                    queue.remove(at: 0)
                }
                else if log.hasMessage(message) {
                    return false
                }
            }
            
            if let lastLog = queue.last?.value, lastLog.time == timestamp {
                lastLog.insertMessage(message)
            }
            else {
                queue.append(Log(time: timestamp, message: message))
            }
            
            return true
        }
    }
}
