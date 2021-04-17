//
//  TodoView.swift
//  TCA+CombineOnboardindTask
//
//  Created by Anastasia Holovash on 2021-04-16.
//

import UIKit
import ComposableArchitecture

final class TodoTableViewCell: UITableViewCell, BindableCell {
  
  private let button = UIButton()
  private let textField = UITextField()
  private var props = Props(descriptionText: "New todo", isComplete: false, id: UUID(), descriptionChanged: nil)
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  struct Props: Equatable, Hashable {
    
    var descriptionText: String
    var isComplete: Bool
    var id: UUID
    var descriptionChanged: ((String) -> Void)?
    var isCompleteChanged: (() -> Void)?
    
    static func == (lhs: TodoTableViewCell.Props, rhs: TodoTableViewCell.Props) -> Bool {
      lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
  }
  
  func render(props: Props) {
    button.setImage(UIImage(systemName: props.isComplete ? "checkmark.square" : "square"), for: .normal)
    textField.text = props.descriptionText

    self.props = props
  }
  
  private func setup() {
    selectionStyle = .none
    contentView.isUserInteractionEnabled = true
    textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    button.addTarget(self, action: #selector(isCompletedDidChange(_:)), for: .touchUpInside)
    
    let horizontalStackView = UIStackView()
    horizontalStackView.axis = .horizontal
    horizontalStackView.spacing = 10
    textField.isUserInteractionEnabled = true
    
    NSLayoutConstraint.activate([
      button.widthAnchor.constraint(equalToConstant: 44)
    ])
    
    horizontalStackView.addArrangedSubview(button)
    horizontalStackView.addArrangedSubview(textField)
    addSubview(horizontalStackView, withEdgeInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
  }
  
  @objc func textFieldDidChange(_ textField: UITextField) {
    props.descriptionChanged?(textField.text ?? "")
  }
  
  @objc func isCompletedDidChange(_ uiButton: UIButton) {
    props.isComplete.toggle()
    render(props: props)
    props.isCompleteChanged?()
  }
}

import SwiftUI
struct TodoViewTableViewCellProvider: PreviewProvider {
  static var previews: some View {
    Group {
      ViewRepresentable(TodoTableViewCell()) {
        $0.render(props: TodoTableViewCell.Props(descriptionText: "New todo",
                                                 isComplete: true, id: UUID()))
      }
      .previewLayout(.fixed(width: 327, height: 44))
    }
  }
}
