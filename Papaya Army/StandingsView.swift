//
//  StandingsView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/3/14.
//

import SwiftUI

struct StandingsView: View {
	let storageFile = StorageManager.FileManagers<[DriverManager.Driver]>(filename: "Standings.json")
	@State private var drivers = [DriverManager.Driver]()
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
			if let drivers = storageFile.loadDataFromFileManager() {
				self.drivers = drivers
			} else {
				DriverManager.shared.retrieveDriverStandings {
					storageFile.saveDataToFileManager($0)
					self.drivers = $0
				}
			}
		}
	}
}

#Preview {
	StandingsView()
}
