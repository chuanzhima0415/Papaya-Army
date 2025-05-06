//
//  TabsView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/3/14.
//

import SwiftUI

struct TabsView: View {
//	let color = Color(red: ConstructorColor.mclaren.red, green: ConstructorColor.mclaren.green, blue: ConstructorColor.mclaren.blue)
	let color: Color = .black
	var seasonId: String
	var body: some View {
		TabView {
			GrandPrixSchedulesView(seasonid: seasonId)
				.tabItem {
					Label("Schedule", systemImage: "calendar.badge.checkmark")
				}
			StandingsView(seasonId: seasonId)
				.tabItem {
					Label("Standings", systemImage: "trophy.fill")
				}
		}
		.accentColor(color)
	}
}

#Preview {
	TabsView(seasonId: "2025")
}
