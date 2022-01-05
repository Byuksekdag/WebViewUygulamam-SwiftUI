//
//  RefreshControl.swift
//  WebView2
//
//  Created by Baris on 20.11.2021.
//

import Foundation
import UIKit
import Combine


class RefreshControl: ObservableObject {
    
    let onValueChanged: ((_ refreshControl: UIRefreshControl) -> Void)
    
    internal init(onValueChanged: @escaping ((UIRefreshControl) -> Void)) {
        self.onValueChanged = onValueChanged
    }
    
    /// Adds a `UIRefreshControl` to the `UIScrollView` provided.
    func add(to scrollView: UIScrollView) {
        scrollView.refreshControl = UIRefreshControl().withTarget(
            self,
            action: #selector(self.onValueChangedAction),
            for: .valueChanged
        ).testable(as: "RefreshControl")
    }
    
    @objc private func onValueChangedAction(sender: UIRefreshControl) {
        self.onValueChanged(sender)
    }
}


extension UIRefreshControl {
    
    /// Convinience method to assign target action inline.
    func withTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) -> UIRefreshControl {
        self.addTarget(target, action: action, for: controlEvents)
        return self
    }
    
    /// Convinience method to match refresh control for UI testing.
    func testable(as id: String) -> UIRefreshControl {
        self.isAccessibilityElement = true
        self.accessibilityIdentifier = id
        return self
    }
}
