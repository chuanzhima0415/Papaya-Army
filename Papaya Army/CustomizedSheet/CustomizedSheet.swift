//
//  CustomizedSheet.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/5/23.
//

import SwiftUI

struct CustomizedSheet<Content: View>: View {
	@Binding var isPresent: Bool
	let content: () -> Content
	let onDismiss: () -> Void
	@GestureState private var dragOffset: CGFloat = 0
	@State private var offsetY: CGFloat = 500
	@State private var lastOffset: CGFloat = 500
	
	var body: some View {
		ZStack {
			Color.red
				.ignoresSafeArea()
			
			if isPresent {
				sheetView
					.offset(y: min(600, max(0, offsetY + dragOffset)))
					.gesture(dragGesture)
					.animation(.spring(), value: dragOffset)
			}
		}
		.frame(maxWidth: .infinity)
	}
	
	var sheetView: some View {
		VStack {
			Capsule()
				.frame(width: 40, height: 6)
				.foregroundColor(.gray.opacity(0.5))
				.padding(.top, 8)
				
			Button {
				withAnimation {
					onDismiss()
					isPresent = false
				}
			} label: {
				Image(systemName: "xmark.app.fill")
					.font(.title)
					.foregroundStyle(.gray)
			}
			.padding(.trailing)
			.frame(maxWidth: .infinity, alignment: .trailing)
			.buttonStyle(.plain)
			
			content()
				
			Spacer()
		}
		.frame(maxWidth: .infinity)
		.background {
			RoundedRectangle(cornerRadius: 20)
				.fill(.ultraThinMaterial)
				.frame(maxWidth: .infinity)
				.ignoresSafeArea(edges: [.bottom, .horizontal])
		}
	}
	
	var dragGesture: some Gesture {
		DragGesture()
			.updating($dragOffset, body: { currentState, gestureState, _ in
				gestureState = currentState.translation.height
			})
			.onEnded({ state in
				if state.translation.height < -100 {
					offsetY = 0
				} else if -100 <= state.translation.height && state.translation.height < 100 { // 回归上一个状态
					offsetY = lastOffset
				} else {
					offsetY = 500
				}
				lastOffset = offsetY
			})
	}
}

#Preview {
	CustomizedSheet(isPresent: .constant(true)) {
		Text("customized sheet")
	} onDismiss: {
		print("on dismiss")
	}
}
