//
//  BindableCell.swift
//  Wendy
//
//  Created by Volodymyr Bondar on 02.02.2021.
//  Copyright © 2021 Uptech Team. All rights reserved.
//

import UIKit

protocol BindableCell: Bindable & ReusableCell { }

extension BindableCell {
  static func cellProvider(
    collectionView: UICollectionView,
    indexPath: IndexPath,
    props: Props
  ) -> UICollectionViewCell? where Self: UICollectionViewCell {
    let cell: Self = collectionView.dequeueReusableCell(forItemAt: indexPath)
    cell.render(props: props)
    return cell
  }

  static func cellProvider(
    tableView: UITableView,
    indexPath: IndexPath,
    props: Props
  ) -> UITableViewCell? where Self: UITableViewCell {
    let cell: Self = tableView.dequeueReusableCell(forItemAt: indexPath)
    cell.render(props: props)
    return cell
  }
}

protocol Bindable {
  associatedtype Props

  func render(props: Props)
}
