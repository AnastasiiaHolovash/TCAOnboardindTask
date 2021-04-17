//
//  AppEnviroment.swift
//  TCA+CombineOnboardindTask
//
//  Created by Anastasia Holovash on 2021-04-16.
//

import UIKit

enum AppEnvironment {
  private static var stack: [Environment] = [makeEnvironment()]

  static var current: Environment! {
    stack.last
  }

  static func pushEnvironment(_ environment: Environment) {
    stack.append(environment)
  }

  @discardableResult
  static func popEnvironment() -> Environment? {
    stack.popLast()
  }
}

struct Environment {
  var todoListService: TodoListService
}

private func makeEnvironment() -> Environment {

  return Environment(todoListService: TodoListServiceImpl())
}
