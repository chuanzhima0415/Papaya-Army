//
//  TabBarPreferenceKey.swift
//  MaterialTabBar
//
//  Created by 马传智 on 2025/5/7.
//

import Foundation
import SwiftUI

struct TabModelPreferenceKey: PreferenceKey { // 向 tabContainer 传最新的 [TabModel]
	static var defaultValue: [TabModel] = []
	
	static func reduce(value: inout [TabModel], nextValue: () -> [TabModel]) {
		value += nextValue()
	}
}

/*************   重写 tabItem modifier  ********************/

struct TabModelViewModifier: ViewModifier {
	let tab: TabModel
	@Binding var activeTab: TabModel
	
	func body(content: Content) -> some View {
		content
			.opacity(activeTab == tab ? 1 : 0)
			.preference(key: TabModelPreferenceKey.self, value: [tab])
	}
}

extension View {
	func tabBarItem(tab: TabModel, selection activeTab: Binding<TabModel>) -> some View {
		self.modifier(TabModelViewModifier(tab: tab, activeTab: activeTab))
	}
}
