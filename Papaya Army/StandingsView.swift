//
//  StandingsView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/3/14.
//

import SwiftUI

struct StandingsView: View {
	@State var drivers = DriverManager.shared.retrieveDriverRaceResult()
	var body: some View {
		NavigationStack {
			List {
				Section {
					ForEach(0 ..< min(3, drivers.count), id: \.self) {
						DriverRowItemView(position: $0 + 1, driver: drivers[$0])
							.swipeActions(edge: .trailing, allowsFullSwipe: false) {
								Button {
									// do something
								} label: {
									Label("Favourite", systemImage: "star")
								}
							}
					}
				}
				Section {
					ForEach(3 ..< drivers.count, id: \.self) {
						DriverRowItemView(position: $0 + 1, driver: drivers[$0])
							.swipeActions(edge: .trailing, allowsFullSwipe: false) {
								Button {
									// do something
								} label: {
									Label("Favourite", systemImage: "star")
								}
							}
					}
				}
			}
			.listStyle(.insetGrouped)
			.navigationTitle("Race Results")
		}
	}
}

#Preview {
	StandingsView()
}
