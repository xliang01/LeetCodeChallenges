//
//  Semaphores.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/6/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class SemaphoreExamples: Runnable {
    static let high = DispatchQueue.global(qos: .userInteractive)
    static let med = DispatchQueue.global(qos: .utility)
    static let low = DispatchQueue.global(qos: .background)
    static let highId = "🔴"
    static let lowId = "🔵"
    static let dispatchGroup = DispatchGroup()
    
    static func wait() {
        while true {
            dispatchGroup.notify(queue: DispatchQueue.main) {
                return
            }
        }
    }
    
    func runTests() {
//        let rw = ReaderWriter()
//        rw.run()
        
        let d = DictionaryThreadSafe()
        d.run()
    }
    
    private class DictionaryThreadSafe {
        var map = [Int: Any]()
        var queue = DispatchQueue(label: "ThreadSafe",
                                  attributes: .concurrent)
        
        func set(val: Any, for key: Int) {
            dispatchGroup.enter()
            queue.async(flags: .barrier) {
                print("Writing")
                self.map[key] = val
                dispatchGroup.leave()
            }
        }
        
        func get(key: Int) -> Any? {
            var result: Any? = nil
            queue.sync {
                result = map[key]
            }
            return map.map { "\($0.key):\($0.value)" }
        }
        
        func run() {
            map.removeAll()
            for i in 1...10 {
                dispatchGroup.enter()
                dispatchGroup.enter()
                DispatchQueue.global(qos: .background).async {
                    print("Getting \(i) \(self.get(key: i))")
                    dispatchGroup.leave()
                }
                if i == 5 {
                    DispatchQueue.global(qos: .background).async {
                        self.set(val: i, for: i)
                        dispatchGroup.leave()
                    }
                }
            }
            wait()
        }
    }
    
    private class ReaderWriter {
        private let readSem = DispatchSemaphore(value: 1)
        private let writeSem = DispatchSemaphore(value: 1)
        var file: String = "Initial"
        var readerCount = 0
        
        func run() {
            for i in 0...10 {
                read(queue: high, reader: "Reader \(i)")
                
                if i == 5 {
                    write(queue: low, writer: "Writer 1", val: "Updated")
                }
            }
            
            for i in 11...20 {
                self.read(queue: low, reader: "Reader \(i)")
                
                if i == 15 {
                    self.write(queue: low, writer: "Writer 2", val: "Updated Again")
                }
            }
            
            wait()
        }
        
        func read(queue: DispatchQueue, reader: String) {
            dispatchGroup.enter()
            queue.async {
                // Wait to avoid race condition of reader counts.
                self.readSem.wait()
                self.readerCount += 1
                // If this is the first reader, lock the writing sem. If the writing is in progress, then this will wait until the write is finished.
                // Otherwise, lock the write to ensure no writers can write.
                if self.readerCount == 1 {
                    print("First \(reader) locks writer.")
                    self.writeSem.wait()
                }
                // Unlock to ensure reader count is incremented and no race condition exists.
                self.readSem.signal()
                
                // Read the file
                print("\(reader) reads: \(self.file)")
                
                // Wait to avoid race condition to decrement reader counts.
                self.readSem.wait()
                self.readerCount -= 1
                
                // If no more readers left, allow writers to write.
                if self.readerCount == 0 {
                    print("Last \(reader) unlocks writer.")
                    self.writeSem.signal()
                }
                
//                print("Reader \(reader) signals after count decrease")
                // Unlock to ensure reader count is incremented and no race condition exists.
                self.readSem.signal()
                dispatchGroup.leave()
            }
        }
        
        func write(queue: DispatchQueue, writer: String, val: String) {
            dispatchGroup.enter()
            queue.async {
                self.writeSem.wait()
                print("\(writer) locks to write")
                self.file = val
                self.writeSem.signal()
                print("\(writer) releases lock")
                dispatchGroup.leave()
            }
        }
    }
    
    private class DeadLock {
        let sem1 = DispatchSemaphore(value: 1)
        let sem2 = DispatchSemaphore(value: 1)
        
        private func asyncPrint(queue: DispatchQueue,
                                symbol: String,
                                firstResource: String,
                                firstSemaphore: DispatchSemaphore,
                                secondResource: String,
                                secondSemaphore: DispatchSemaphore) {
            dispatchGroup.enter()
            queue.async {
                print("\(symbol) \(firstResource) is waiting...")
                firstSemaphore.wait()
                
                for i in 0...10 {
                    if i == 10/2 {
                        print("\(symbol) \(secondResource) is waiting...")
                        secondSemaphore.wait()
                    }
                    print("\(symbol) \(i)")
                }
                print("\(symbol) releasing resources")
                firstSemaphore.signal()
                secondSemaphore.signal()
                
                dispatchGroup.leave()
            }
        }
        
        func run() {
            asyncPrint(queue: high,
                       symbol: highId,
                       firstResource: "A",
                       firstSemaphore: sem1,
                       secondResource: "B",
                       secondSemaphore: sem2)
            
            asyncPrint(queue: low,
                       symbol: lowId,
                       firstResource: "B",
                       firstSemaphore: sem2,
                       secondResource: "A",
                       secondSemaphore: sem1)
            wait()
        }
    }
    
    private class PriorityInversion {
        let sem = DispatchSemaphore(value: 1)
        
        private func asyncPrint(queue: DispatchQueue, symbol: String) {
            dispatchGroup.enter()
            queue.async {
                print("\(symbol) is waiting...")
                self.sem.wait()
                
                for i in 0...10 {
                    print("\(i), \(symbol)")
                }
                
                print("\(symbol) signal")
                self.sem.signal()
                dispatchGroup.leave()
            }
        }
        
        func run() {
            asyncPrint(queue: high, symbol: "🔵")
            asyncPrint(queue: low, symbol: "🔴")
            wait()
        }
    }
}
