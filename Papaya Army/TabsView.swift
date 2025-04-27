//
//  TabsView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/3/14.
//

import SwiftUI

struct TabsView: View {
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
			Text("Hello")
				.tabItem {
					Label("Settings", systemImage: "gear")
				}
		}
		.accentColor(color)
	}
	let color = Color(red: 255 / 255, green: 128 / 255, blue: 0)
}

#Preview {
	TabsView(seasonId: "2025")
}
