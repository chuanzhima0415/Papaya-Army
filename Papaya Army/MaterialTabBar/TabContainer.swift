//
//  TabContainer.swift
//  FloatingTabBar
//
//  Created by 马传智 on 2025/5/7.
//

import SwiftUI

struct TabContainer<Content: View>: View {
	var content: Content
	@Binding var selection: TabModel
	@Binding var cards: [Card]
	@State private var tabs: [TabModel] = []
	
	init(cards: Binding<[Card]>, selection: Binding<TabModel>, @ViewBuilder content: () -> Content) {
		self._selection = selection
		self.content = content()
		self._cards = cards
	}
	
	var body: some View {
		ZStack {
			content
				.ignoresSafeArea()
			
			MaterialTabBar(tabs: tabs, selection: $selection, cards: $cards)
		}
		.onPreferenceChange(TabModelPreferenceKey.self) { tabs in
			self.tabs = tabs
		}
	}
}

#Preview {
	TabContainer(cards: .constant([
		Card(offset: 0, id: 0, roundIndex: 3),
		Card(offset: 1, id: 1, roundIndex: 2),
		Card(offset: 2, id: 2, roundIndex: 1),
		Card(offset: 3, id: 3, roundIndex: 0),
	]), selection: .constant(.schedule)) {
		Color.orange
	}
}
