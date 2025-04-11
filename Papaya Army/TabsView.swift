//
//  TabsView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/3/14.
//

import SwiftUI

struct TabsView: View {
	var body: some View {
		TabView {
			ContentView()
				.tabItem {
					Label("main", systemImage: "star")
				}
			GrandPrixSchedulesView()
				.tabItem {
					Label("Schedule", systemImage: "calendar.badge.checkmark")
				}
			StandingsView(seasonId: "sr:stage:1107547")
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
	TabsView()
}
