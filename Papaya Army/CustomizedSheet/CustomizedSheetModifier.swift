//
//  CustomizedSheetModifier.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/5/24.
//

import SwiftUI

extension View {
	func customizedSheet<Item: Identifiable, Content: View>(
		selectedItem: Binding<Item?>,
		onDismiss: (() -> Void)? = nil,
		@ViewBuilder content: @escaping (Item) -> Content
	) -> some View {
		self
			.overlay {
				if let selected = selectedItem.wrappedValue {
					CustomizedSheet(isPresent: .constant(true)) {
						content(selected)
					} onDismiss: {
						selectedItem.wrappedValue = nil
						if let onDismiss { onDismiss() }
					}
					.transition(.move(edge: .bottom))
					.zIndex(1)
				}
			}
	}
}
