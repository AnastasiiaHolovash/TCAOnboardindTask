//
//  TodoListStore.swift
//  TCA+CombineOnboardindTask
//
//  Created by Anastasia Holovash on 2021-04-16.
//

import UIKit
import ComposableArchitecture

extension TodoListViewController {
  
  struct State: Equatable {
    var todos: [Todo] = []
    
    static let initial = State(todos: [])
  }
  
  enum Action {
    case todoCheckboxTapped(todo: Todo)
    case todoTextFieldChanged(todo: Todo, newText: String)
    case todoAdded(todo: Todo)
    case todoDeleted(todo: Todo)
    case getTodosList
    case todosLoaded(todos: [Todo])
  }
  
  struct Environment {
    var addTodo: (_ todo: Todo) -> Void
    var update: (_ todo: Todo) -> Void
    var getTodos: () -> [Todo]
    var delete: (_ todo: Todo) -> Void
  }
  
  static func reducer(state: inout State, action: Action, environment: Environment) -> Effect<Action, Never> {
    switch action {
    case .todoCheckboxTapped(let todo):
      guard let index = state.todos.firstIndex(of: todo) else {
        return .none
      }
      state.todos[index].isComplete.toggle()
      return .fireAndForget { [state] in
        environment.update(state.todos[index])
      }
      
    case .todoTextFieldChanged(let todo, let text):
      guard let index = state.todos.firstIndex(of: todo) else {
        return .none
      }
      state.todos[index].description = text
      return .fireAndForget { [state] in
          environment.update(state.todos[index])
      }
      
    case .todoAdded(let todo):
      state.todos.append(todo)
      return .fireAndForget {
        environment.addTodo(todo)
      }
      
    case .todoDeleted(let todo):
      state.todos.removeAll { $0 == todo }
      return .fireAndForget {
        environment.delete(todo)
      }
      
    case .getTodosList:
      let todos = environment.getTodos()
      return Effect(value: Action.todosLoaded(todos: todos))
      
    case .todosLoaded(let todos):
      state.todos = todos
      return .none
    }
  }
  
  func makeProps(state: State) -> [TodoTableViewCell.Props] {
    return store.state.todos.map { todo in
      TodoTableViewCell.Props(descriptionText: todo.description, isComplete: todo.isComplete, id: todo.id) { [weak self] text in
      self?.store.send(.todoTextFieldChanged(todo: todo, newText: text))
      } isCompleteChanged: { [weak self] in
        self?.store.send(.todoCheckboxTapped(todo: todo))
      }
    }
  }
}
