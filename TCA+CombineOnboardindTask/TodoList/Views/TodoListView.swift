//
//  TodoListView.swift
//  TCA+CombineOnboardindTask
//
//  Created by Anastasia Holovash on 2021-04-16.
//

import UIKit

final class TodoListView: UIView {
  
  let tableView = UITableView()
  private var props: [TodoTableViewCell.Props] = []
  private lazy var dataSource = makeDataSource()
  
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
  }
  
  private func setupUI() {
    tableView.register(TodoTableViewCell.self)
    tableView.rowHeight = 44
    addSubview(tableView, withEdgeInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
  }
  
  private func makeDataSource() -> UITableViewDiffableDataSource<SingleSection, TodoTableViewCell.Props> {
    UITableViewDiffableDataSource(tableView: tableView, cellProvider: TodoTableViewCell.cellProvider)
  }
}

//extension TodoListView: UITableViewDelegate {
//  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//      return tableView.isEditing ? .delete : .none
//  }
//}

import SwiftUI
struct TodoListViewProvider: PreviewProvider {
  static var previews: some View {
    Group {
      ViewRepresentable(TodoListView())
    }
  }
}
