//
//  ContentView.swift
//  Papaya Army
//
//  Just for experimental draft !!!!!
//
//  Created by 马传智 on 2025/5/10.
//

import SwiftUI

//struct ScrollOffsetPreferenceKey: PreferenceKey {
//	static var defaultValue: CGFloat = 0
//	static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
//		value = nextValue()
//	}
//}
//
//struct ContentView: View {
//	@State private var showingHeader = true
//	
//	var body: some View {
//		VStack {
//			if showingHeader {
//				HeaderView()
//					.transition(
//						.asymmetric(
//							insertion: .push(from: .top),
//							removal: .push(from: .bottom)
//						)
//					)
//			}
//			GeometryReader { outer in
//				let outerHeight = outer.size.height
//				ScrollView(.vertical) {
//					content
//						.background {
//							GeometryReader { proxy in
//								let contentHeight = proxy.size.height
//								let minY = max(
//									min(0, proxy.frame(in: .named("ScrollView")).minY),
//									outerHeight - contentHeight
//								)
//								Color.clear
//									.onChange(of: minY) { oldVal, newVal in
//										if (showingHeader && newVal < oldVal) || !showingHeader && newVal > oldVal {
//											showingHeader = newVal > oldVal
//										}
//									}
//							}
//						}
//				}
//				.coordinateSpace(name: "ScrollView")
//			}
//				// Prevent scrolling into the safe area
//			.padding(.top, 1)
//		}
//		.background(.black)
//		.animation(.easeInOut, value: showingHeader)
//	}
//}
//
//#Preview {
//	ContentView()
//}
