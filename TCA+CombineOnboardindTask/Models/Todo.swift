//
//  Todo.swift
//  TCA+CombineOnboardindTask
//
//  Created by Anastasia Holovash on 2021-04-16.
//

import Foundation

struct Todo: Equatable, Hashable {
  var description = ""
  var isComplete = false
  let id = UUID()
  
  static func == (lhs: Todo, rhs: Todo) -> Bool {
    lhs.id == rhs.id
  }
  
//  func hash(into hasher: inout Hasher) {
//    hasher.combine(id)
//  }
  
  static let initial = Todo(description: "New todo", isComplete: false)
}

