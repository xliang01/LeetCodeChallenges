//
//  ListNode.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/22/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

//Definition for singly-linked list.
public class ListNode {
  public var val: Int
  public var next: ListNode?
  public init(_ val: Int) {
      self.val = val
      self.next = nil
  }
}
