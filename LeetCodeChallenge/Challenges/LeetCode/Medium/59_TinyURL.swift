//
//  59_TinyURL.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/8/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class TinyURL: Runnable {
    func runTests() {
        let solution = SolutionHashMap()
        let tinyURL = solution.encode("http://www.cnn.com")
        print(tinyURL)
        print(solution.decode(tinyURL)!)
    }
    
    class SolutionHashMap {
        var hash = [String: String]()
        var sample = Array<Character>("0123456789abcdefghijklmnopqrstuvwxyz")
        let urlSize = 6
        
        // Encodes a URL to a shortened URL.
        func encode(_ longUrl: String) -> String {
            var key = generateKey()
            while hash[key] != nil {
                key = generateKey()
            }
            let shortURL = "http://tinyurl.com/\(key)"
            hash[key] = longUrl
            return shortURL
        }
        
        // Decodes a shortened URL to its original URL.
        func decode(_ shortUrl: String) -> String? {
            let key = String(shortUrl.suffix(urlSize))
            return hash[key]
        }
        
        private func generateKey() -> String {
            var chars = [Character]()
            for _ in 0..<urlSize {
                let randomIndex = Int.random(in: 0...sample.count-1)
                let randomChar = sample[randomIndex]
                chars.append(randomChar)
            }
            return String(chars)
        }
    }
}

// Your Solution object will be instantiated and called as such:
// Solution solution;
// solution.decode(solution.encode(url));
