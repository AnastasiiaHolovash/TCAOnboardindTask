//
//  ViewRepresentable.swift
//  Wendy
//
//  Created by Volodymyr Bondar on 26.01.2021.
//  Copyright © 2021 Uptech Team. All rights reserved.
//

import SwiftUI
import UIKit

struct ViewRepresentable<View: UIView>: UIViewRepresentable {
  let view: View

  init(_ view: View, setup: (View) -> Void = { _ in }) {
    self.view = view
    setup(view)
  }

  func makeUIView(context: Context) -> View {
    view
  }

  func updateUIView(_ uiView: View, context: Context) { }
}

extension ViewRepresentable where View: Bindable {
  init(_ view: View, props: View.Props) {
    self.init(view) { view in
      view.render(props: props)
    }
  }
}
