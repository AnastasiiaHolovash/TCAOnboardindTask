//
//  TodoListService.swift
//  TCA+CombineOnboardindTask
//
//  Created by Anastasia Holovash on 2021-04-16.
//

import Foundation
import Combine

protocol TodoListService {
  func add(_ todo: Todo)
  func update(_ todo: Todo)
  func getTodos() -> [Todo]
  func delete(_ todo: Todo)
}

final class TodoListServiceImpl: TodoListService {

  private var todosArray: [Todo] = []
  
  init() {
    todosArray = (1...10).map{ Todo(description: "New item \($0)", isComplete: false) }
  }
  
  func getTodos() -> [Todo] {
    return todosArray
  }
  
  func add(_ todo: Todo) {
    todosArray.append(todo)
  }
  
  func update(_ todo: Todo) {
    if let index = todosArray.firstIndex(of: todo) {
      todosArray.remove(at: index)
      todosArray.insert(todo, at: index)
    }
  }
  
  func delete(_ todo: Todo) {
    todosArray.removeAll { $0 == todo }
  }
}
