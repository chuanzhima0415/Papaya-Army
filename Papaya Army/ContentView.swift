//
//  ContentView.swift
//  Papaya Army
//
//  Just for experimental draft !!!!!
//
//  Created by 马传智 on 2025/5/10.
//

import SwiftUI

struct ContentView: View {
	@State private var showingHeader = true
	
	@State private var offsetY: CGFloat = 0
	@GestureState private var dragOffset: CGFloat = 0
		
	var body: some View {
		ZStack {
			Color.red.opacity(1)
				.ignoresSafeArea()
				.onTapGesture {
					// 点击背景关闭
					offsetY = 400
				}
				
			sheetView
				.offset(y: max(offsetY + dragOffset, 0)) // 不允许往上拖过顶
				.gesture(
					DragGesture()
						.updating($dragOffset) { currentState, gestureState, _ in
							gestureState = currentState.translation.height
						}
						.onEnded { value in
							// 根据拖动距离决定是收回、展开、保持
							if value.translation.height > 150 {
								offsetY = 600 // 关闭
							} else {
								offsetY = 0 // 弹回
							}
						}
				)
				.animation(.spring(), value: dragOffset)
		}
		.onAppear {
			// 初始从底部弹出
//			offsetY = 600
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
				withAnimation(.spring()) {
					offsetY = 400
				}
			}
		}
	}
		
	var sheetView: some View {
		VStack {
			Capsule()
				.frame(width: 40, height: 6)
				.foregroundColor(.gray.opacity(0.5))
				.padding(.top, 8)
				
			Text("这是可拖动的 Sheet")
				.font(.headline)
				.padding()
				
			Spacer()
		}
		.frame(height: .infinity)
		.frame(maxWidth: .infinity)
		.background(
			RoundedRectangle(cornerRadius: 20)
				.fill(.ultraThinMaterial)
				.ignoresSafeArea(edges: .bottom)
		)
	}
}

#Preview {
	ContentView()
}
