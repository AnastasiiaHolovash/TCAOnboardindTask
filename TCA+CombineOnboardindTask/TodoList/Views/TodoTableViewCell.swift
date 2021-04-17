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
  
  struct Props: Hashable {
    
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
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
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
    textField.isUserInteractionEnabled = true
    
    horizontalStackView.addArrangedSubview(button)
    horizontalStackView.addArrangedSubview(textField)
    addSubview(horizontalStackView, withEdgeInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    NSLayoutConstraint.activate([
      button.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.15)
    ])
  }
  
  @objc func textFieldDidChange(_ textField: UITextField) {
    props.descriptionText = textField.text ?? ""
    render(props: props)
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
