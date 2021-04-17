//
//  TodoListViewController.swift
//  TCA+CombineOnboardindTask
//
//  Created by Anastasia Holovash on 2021-04-16.
//

import UIKit
import ComposableArchitecture
import Combine

class TodoListViewController: UIViewController {

  lazy var store = createStore()
  private lazy var contentView = TodoListView()
  private var cancellables: Set<AnyCancellable> = []
  
  private var addTodoButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
  private var editTodoButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
  
  override func loadView() {
    view = contentView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
    store.send(.getTodosList)
    
    store.publisher
      .map {
        $0
      }
      .map(makeProps)
      .sink { [unowned self] props in contentView.render(props: props) } 
      .store(in: &cancellables)

    setupUI()
  }
  
  private func setupUI() {
    view.backgroundColor = .systemBackground
    
    let addTodoButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    let editTodoButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
    navigationItem.rightBarButtonItem = addTodoButton
    navigationItem.leftBarButtonItem = editTodoButton
  }
  
  @objc func addTapped() {
    store.send(.todoAdded(todo: Todo.initial()))
  }
  
  @objc func editTapped() {
//    contentView.tableView.isEditing = true
    
  }

  private func createStore() -> ViewStore<State, Action> {
    let environment = Environment(addTodo: AppEnvironment.current.todoListService.add(_:),
                                  update: AppEnvironment.current.todoListService.update(_:),
                                  getTodos: AppEnvironment.current.todoListService.getTodos,
                                  delete: AppEnvironment.current.todoListService.delete(_:))
    return ViewStore(Store(
      initialState: .initial,
      reducer: Reducer(Self.reducer).debug(),
      environment: environment
    ))
  }
}
