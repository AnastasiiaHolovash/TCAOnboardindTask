//
//  TodoListView.swift
//  TCA+CombineOnboardindTask
//
//  Created by Anastasia Holovash on 2021-04-16.
//

import UIKit

final class TodoListView: UIView {
  
  private let tableView = UITableView()
  private var props: [TodoTableViewCell.Props] = []
  private lazy var dataSource = makeDataSource()
  
  var didDeleteTodo: ((TodoTableViewCell.Props, IndexPath) -> Void)?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func render(props: [TodoTableViewCell.Props]) {
    dataSource.applyItems(props)
    self.props = props
    
    dataSource.didDeleteItem = didDeleteTodo
  }
  
  private func setupUI() {
    tableView.register(TodoTableViewCell.self)
    tableView.rowHeight = 44
    addSubview(tableView, withEdgeInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
  }
  
  private func makeDataSource() -> TableDiffableDataSource<SingleSection, TodoTableViewCell.Props> {
    TableDiffableDataSource(tableView: tableView, cellProvider: TodoTableViewCell.cellProvider)
  }
}

import SwiftUI
struct TodoListViewProvider: PreviewProvider {
  static var previews: some View {
    Group {
      ViewRepresentable(TodoListView())
    }
  }
}
