//
//  TableDiffableDataSource.swift
//  TCA+CombineOnboardindTask
//
//  Created by Anastasia Holovash on 2021-04-17.
//

import UIKit

final class TableDiffableDataSource<SectionIdentifierType: Hashable, ItemIdentifierType: Hashable>: UITableViewDiffableDataSource<SectionIdentifierType, ItemIdentifierType> {
  
  var didDeleteItem: ((IndexPath) -> Void)?
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete,
       let model = itemIdentifier(for: indexPath) {
      
      var snapshot = self.snapshot()
      snapshot.deleteItems([model])
      didDeleteItem?(indexPath)
      apply(snapshot)
    }
  }
}
