//
//  StandingsView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/3/14.
//

import SwiftUI

struct StandingsView: View {
	@State private var drivers = [Driver]()
	@State private var selectedDriver: Driver?
	var body: some View {
		NavigationStack {
			if drivers.isEmpty {
				ProgressView("Loading standings...")
			} else {
				List {
					Section {
						ForEach(0 ..< min(3, drivers.count), id: \.self) {
							DriverRowItemView(position: drivers[$0].standingPos, driver: drivers[$0])
								.swipeActions(edge: .trailing, allowsFullSwipe: false) {
									Button {
										// do something
									} label: {
										Label("Good Job!", systemImage: "hand.thumbsup")
									}
									Button {
										// Jump into driver details
									} label: {
										Label("Jump to details", systemImage: "info.bubble")
									}

								}
						}
					}
					Section {
						ForEach(3 ..< max(3, drivers.count), id: \.self) {
							DriverRowItemView(position: drivers[$0].standingPos, driver: drivers[$0])
								.swipeActions(edge: .trailing, allowsFullSwipe: false) {
									Button {
										// do something
									} label: {
										Label("Good Job!", systemImage: "hand.thumbsup")
									}
								}
						}
					}
				}
				.listStyle(.insetGrouped)
				.navigationTitle("Standings")
			}
		}
		.onAppear {
			DriverManager.shared.retrieveDriverStandings { drivers in
				self.drivers = drivers
			}
		}
	}
}

#Preview {
	StandingsView()
}
