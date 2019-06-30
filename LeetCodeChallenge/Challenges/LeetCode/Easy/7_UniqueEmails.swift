//
//  7_UniqueEmails.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 3/21/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class UniqueEmails: Runnable {
    func runTests() {
        let solution1 = SolutionDictionarySet()
        print(solution1.numUniqueEmails(["test.email+alex@leetcode.com",
                                         "test.e.mail+bob.cathy@leetcode.com",
                                         "testemail+david@lee.tcode.com"]))
        
        print(solution1.numUniqueEmails(["testemail@leetcode.com",
                                         "testemail1@leetcode.com",
                                         "testemail+david@lee.tcode.com"]))
        
        let solution2 = SolutionUniqueSum()
        print(solution2.numUniqueEmails(["test.email+alex@leetcode.com",
                                         "test.e.mail+bob.cathy@leetcode.com",
                                         "testemail+david@lee.tcode.com"]))
        
        print(solution2.numUniqueEmails(["testemail@leetcode.com",
                                         "testemail1@leetcode.com",
                                         "testemail+david@lee.tcode.com"]))
        
        let solution3 = SolutionIndexIterate()
        print(solution3.numUniqueEmails(["test.email+alex@leetcode.com",
                                         "test.e.mail+bob.cathy@leetcode.com",
                                         "testemail+david@lee.tcode.com"]))
        
        print(solution3.numUniqueEmails(["testemail@leetcode.com",
                                         "testemail1@leetcode.com",
                                         "testemail+david@lee.tcode.com"]))
    }
    
    /**
        Every email consists of a local name and a domain name, separated by the @ sign.

        For example, in alice@leetcode.com, alice is the local name, and leetcode.com is the domain name.

        Besides lowercase letters, these emails may contain '.'s or '+'s.

        If you add periods ('.') between some characters in the local name part of an email address, mail sent there will be forwarded to the same address without dots in the local name.  For example, "alice.z@leetcode.com" and "alicez@leetcode.com" forward to the same email address.  (Note that this rule does not apply for domain names.)

        If you add a plus ('+') in the local name, everything after the first plus sign will be ignored. This allows certain emails to be filtered, for example m.y+name@email.com will be forwarded to my@email.com.  (Again, this rule does not apply for domain names.)

        It is possible to use both of these rules at the same time.

        Given a list of emails, we send one email to each address in the list.  How many different addresses actually receive mails?
    */
    private class SolutionDictionarySet {
        func numUniqueEmails(_ emails: [String]) -> Int {
            var count = 0
            var emailDictionary = [String: Set<String>]()
            
            for email in emails {
                let emailParts = email.split(separator: "@")
                let localName = String(emailParts[0])
                let domain = String(emailParts[1])
                let filteredLocalName = localName.split(separator: "+")[0].replacingOccurrences(of: ".", with: "")
                
                if emailDictionary[domain] == nil {
                    emailDictionary[domain] = Set<String>()
                }
                emailDictionary[domain]?.insert(filteredLocalName)
            }
            
            for (_, filteredLocalNameSet) in emailDictionary {
                count += filteredLocalNameSet.count
            }
            
            return count
        }
    }
    
    private class SolutionUniqueSum {
        func numUniqueEmails(_ emails: [String]) -> Int {
            var uniqueEmails = Set<String>()
            
            for email in emails {
                let emailParts = email.split(separator: "@")
                let localName = String(emailParts[0])
                let domain = String(emailParts[1])
                let filteredLocalName = localName.split(separator: "+")[0].split(separator: ".").joined()
                uniqueEmails.insert(filteredLocalName + domain)
            }
            
            return uniqueEmails.count
        }
    }
    
    private class SolutionIndexIterate {
        func numUniqueEmails(_ emails: [String]) -> Int {
            var uniqueEmails = Set<String>()
            
            for email in emails {
                var localAndReversedDomain = ""
                var localNameIndex = email.startIndex
                
                // Iterate from the beginning of the string to @ or +.
                while case let character = email[localNameIndex], character != "@", character != "+" {
                    if character != "." {
                        localAndReversedDomain.append(character)
                    }
                    localNameIndex = email.index(after: localNameIndex)
                }
                
                // Iterate from end to @.
                var domainIndex = email.index(before: email.endIndex)
                while case let character = email[domainIndex], character != "@" {
                    localAndReversedDomain.append(character)
                    domainIndex = email.index(before: domainIndex)
                }
    
                uniqueEmails.insert(localAndReversedDomain)
            }
            
            return uniqueEmails.count
        }
    }
}
