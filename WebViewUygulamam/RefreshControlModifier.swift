//
//  RefreshControlModifier.swift
//  WebView2
//
//  Created by Baris on 20.11.2021.
//

import Foundation
import SwiftUI


struct RefreshControlModifier: ViewModifier {
    
    @State var geometryReaderFrame: CGRect = .zero
    let refreshControl: RefreshControl
    
    internal init(onValueChanged: @escaping (UIRefreshControl) -> Void) {
        self.refreshControl = RefreshControl(onValueChanged: onValueChanged)
    }
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    ScrollViewMatcher(
                        onResolve: { scrollView in
                            refreshControl.add(to: scrollView)
                        },
                        geometryReaderFrame: $geometryReaderFrame
                    )
                    .preference(key: FramePreferenceKey.self, value: geometry.frame(in: .global))
                    .onPreferenceChange(FramePreferenceKey.self) { frame in
                        self.geometryReaderFrame = frame
                    }
                }
            )
    }
}


extension View {
    
    func refreshControl(onValueChanged: @escaping (_ refreshControl: UIRefreshControl) -> Void) -> some View {
        self.modifier(RefreshControlModifier(onValueChanged: onValueChanged))
    }
}
