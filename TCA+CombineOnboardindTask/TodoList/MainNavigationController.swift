//
//  MainNavigationController.swift
//  TCA+CombineOnboardindTask
//
//  Created by Anastasia Holovash on 2021-04-16.
//

import UIKit

final class MainNavigationController: UINavigationController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  func setup() {
    setViewControllers([TodoListViewController()], animated: true)
  }
}
