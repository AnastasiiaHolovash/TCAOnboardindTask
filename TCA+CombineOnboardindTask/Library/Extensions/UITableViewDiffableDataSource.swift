//
//  UITableViewExtensions.swift
//  Wendy
//
//  Created by Illia Postoienko on 16.02.2021.
//  Copyright © 2021 Uptech Team. All rights reserved.
//

import UIKit

extension UITableViewDiffableDataSource where SectionIdentifierType == SingleSection {
  func applyItems(_ items: [ItemIdentifierType], animated: Bool = true) {
    var snapshot = NSDiffableDataSourceSnapshot<SingleSection, ItemIdentifierType>()
    snapshot.appendSections([.main])
    snapshot.appendItems(items, toSection: .main)
    apply(snapshot, animatingDifferences: animated)
  }
}
