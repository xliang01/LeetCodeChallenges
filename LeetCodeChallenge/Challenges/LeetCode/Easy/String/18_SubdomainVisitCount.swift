//
//  SubdomainVisitCount.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 3/24/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

/**
 A website domain like "discuss.leetcode.com" consists of various subdomains. At the top level, we have "com", at the next level, we have "leetcode.com", and at the lowest level, "discuss.leetcode.com". When we visit a domain like "discuss.leetcode.com", we will also visit the parent domains "leetcode.com" and "com" implicitly.
 
 Now, call a "count-paired domain" to be a count (representing the number of visits this domain received), followed by a space, followed by the address. An example of a count-paired domain might be "9001 discuss.leetcode.com".
 
 We are given a list cpdomains of count-paired domains. We would like a list of count-paired domains, (in the same format as the input, and in any order), that explicitly counts the number of visits to each subdomain.
 
 Example 1:
 Input:
 ["9001 discuss.leetcode.com"]
 Output:
 ["9001 discuss.leetcode.com", "9001 leetcode.com", "9001 com"]
 Explanation:
 We only have one website domain: "discuss.leetcode.com". As discussed above, the subdomain "leetcode.com" and "com" will also be visited. So they will all be visited 9001 times.
 
 Example 2:
 Input:
 ["900 google.mail.com", "50 yahoo.com", "1 intel.mail.com", "5 wiki.org"]
 Output:
 ["901 mail.com","50 yahoo.com","900 google.mail.com","5 wiki.org","5 org","1 intel.mail.com","951 com"]
 Explanation:
 We will visit "google.mail.com" 900 times, "yahoo.com" 50 times, "intel.mail.com" once and "wiki.org" 5 times. For the subdomains, we will visit "mail.com" 900 + 1 = 901 times, "com" 900 + 50 + 1 = 951 times, and "org" 5 times.
*/
class SubdomainVisitCount: Runnable {
    func runTests() {
        let solution1 = SolutionHashCount()
        print(solution1.subdomainVisits(["900 google.mail.com", "50 yahoo.com", "1 intel.mail.com", "5 wiki.org"]))
        print(solution1.subdomainVisits(["10 wiki.org", "5 wiki.org"]))
    }
    
    private class SolutionHashCount {
        /**
            Solution:
         
            For each string, capture the entire domain count in a hashmap. Then iterate through the domain
            to get the subdomain and capture its individual counts using the hashmap.
         
            Performance:
         
            Time Complexity: O(N) for number of iterations.
            Space Complexity: O(N) for space used for the count.
         */
        func subdomainVisits(_ cpdomains: [String]) -> [String] {
            var domains = [String]()
            var countMap = [String: Int]()
            
            for domain in cpdomains {
                let info = Array(domain.split(separator: " "))
                let count = Int(info[0])!
                let domainString = String(info[1])
                let characters = Array<Character>(domainString)
                let size = characters.count
                
                if let domainCount = countMap[domainString] {
                    countMap[domainString] = domainCount + count
                }
                else {
                    countMap[domainString] = count
                }
                
                for index in (0..<size).reversed() {
                    if characters[index] == "." {
                        let offset = size - index - 1
                        let domainSuffixIndex = domainString.index(domainString.endIndex, offsetBy: -offset)
                        let domain = String(domainString.suffix(from: domainSuffixIndex))
                        
                        if let domainCount = countMap[domain] {
                            countMap[domain] = domainCount + count
                        }
                        else {
                            countMap[domain] = count
                        }
                    }
                }
            }
            
            for (key, value) in countMap {
                domains.append("\(value) \(key)")
            }
            
            return domains
        }
    }
}
