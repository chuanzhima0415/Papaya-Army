//
//  FloatingTabBar.swift
//  FloatingTabBar
//
//  Created by 马传智 on 2025/5/7.
//

import SwiftUI

struct MaterialTabBar: View {
	var tabs: [TabModel]
	@Binding var selection: TabModel
	@Binding var cards: [Card]
	private let contentShape = RoundedRectangle(cornerRadius: 5)
	
	@Namespace private var namespace // For matchedGeometryEffect
	
	var body: some View {
		VStack {
			Spacer()
			
			HStack {
				if selection == .schedule {
					Button {
						hapticFeedback(.medium)
						reshuffleCard()
					} label: {
						Image(systemName: "arrow.clockwise.circle.fill")
							.font(.system(size: 50, weight: .bold))
							.foregroundStyle(TabModel.schedule.color.opacity(0.8))
							.background(Circle().fill(.ultraThinMaterial))
							.shadow(color: .secondary.opacity(0.3), radius: 10, y: 5)
							.padding(.leading)
					}
					.matchedGeometryEffect(id: "reshuffle button", in: namespace)
					.transition(.scale.combined(with: .opacity))
					.animation(.spring(response: 0.4, dampingFraction: 0.6), value: selection)
				}
				
				HStack {
					ForEach(tabs, id: \.self) { tab in
						tabView(tab: tab)
					}
				}
				.background(content: {
					contentShape
						.foregroundStyle(.ultraThinMaterial)
				})
				.clipShape(Capsule())
				.shadow(color: .secondary.opacity(0.3), radius: 10, y: 5)
				.padding(.horizontal)
			}
		}
	}
	
	/// 重置卡片
	private func reshuffleCard() {
		withAnimation {
			cards = [
				Card(offset: 0, id: 0, roundIndex: 3),
				Card(offset: 1, id: 1, roundIndex: 2),
				Card(offset: 2, id: 2, roundIndex: 1),
				Card(offset: 3, id: 3, roundIndex: 0),
			]
		}
	}
	
	private func hapticFeedback(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
		let generator = UIImpactFeedbackGenerator(style: style)
		generator.prepare()
		generator.impactOccurred()
	}
}

#Preview {
	MaterialTabBar(tabs: [.schedule, .standing], selection: .constant(.schedule), cards: .constant(
		[
			Card(offset: 0, id: 0, roundIndex: 3),
			Card(offset: 1, id: 1, roundIndex: 2),
			Card(offset: 2, id: 2, roundIndex: 1),
			Card(offset: 3, id: 3, roundIndex: 0),
		]
	))
}

extension MaterialTabBar {
	func tabView(tab: TabModel) -> some View {
		VStack {
			if selection == tab {
				Image(systemName: tab.iconName)
					.font(.title2.weight(.bold))
					.foregroundStyle(tab.color)
					.frame(height: 15)
					.padding(.vertical, 8)
					.symbolEffect(.bounce, value: selection)
					.shadow(radius: 0.5, y: 1)
			} else {
				Image(systemName: tab.iconName)
					.font(.title2)
					.foregroundStyle(.secondary)
					.frame(height: 15)
					.padding(.vertical, 8)
			}
			
			Text(tab.title)
				.font(.system(size: 14, weight: tab == selection ? .bold : .semibold, design: .rounded))
				.foregroundStyle(selection == tab ? .white : .secondary)
		}
		.frame(maxWidth: .infinity)
		.frame(height: 70)
		.padding(.vertical, 5)
		.background {
			Group {
				if selection == tab {
					contentShape
						.fill(tab.color.opacity(0.2))
						.matchedGeometryEffect(id: "tabHighlighting", in: namespace)
				}
			}
		}
		.contentShape(contentShape) // 使点击区域的形状为 contentShape(原来是 Image + Text 的 VStack 矩形)
		.onTapGesture {
			switchToTab(tab)
		}
	}
	
	private func switchToTab(_ newTab: TabModel) {
		withAnimation(.bouncy(duration: 0.3, extraBounce: .zero)) {
			selection = newTab
		}
	}
}
