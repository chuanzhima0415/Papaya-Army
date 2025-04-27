//
//  DriverStandingsView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/27.
//

import SwiftUI

struct DriverStandingSwipeModifier: ViewModifier {
	func body(content: Content) -> some View {
		content
			.swipeActions(edge: .trailing, allowsFullSwipe: false) {
				Button {
						// do something
				} label: {
					Label("Good Job!", systemImage: "hand.thumbsup")
				}
			}
	}
}

extension View {
	func driverStandingSwipeModifier() -> some View {
		self.modifier(DriverStandingSwipeModifier())
	}
}

struct DriverStandingsView: View {
	private var fileURL: StorageManager.FileManagers<[DriversStanding]> {
		StorageManager.FileManagers(filename: "Driver standings.json")
	}

	var seasonId: String
	@State private var driverStandings: [DriversStanding]?
	var body: some View {
		NavigationStack {
			if let driverStandings {
				List {
					Section {
						ForEach(0 ..< min(3, driverStandings.count), id: \.self) { index in
							HStack {
								NavigationLink {
									DriverDetailInfoView(driverDetail: driverStandings[index].driverDetailInfo)
								} label: {
									HStack {
										DriverStandingRowItemView(driverStanding: driverStandings[index])
									}
								}
								.driverStandingSwipeModifier()
							}
						}
					}
					Section {
						ForEach(3 ..< max(3, driverStandings.count), id: \.self) { index in
							HStack {
								NavigationLink {
									DriverDetailInfoView(driverDetail: driverStandings[index].driverDetailInfo)
								} label: {
									HStack {
										DriverStandingRowItemView(driverStanding: driverStandings[index])
									}
								}
								.driverStandingSwipeModifier()
							}
						}
					}
				}
				.listStyle(.insetGrouped)
			} else {
				ProgressView("Loading Standings...")
			}
		}
		.onAppear {
			Task {
				// 优先加载本地的（尽量不要出现圈圈）
				if let driverStandings = fileURL.loadDataFromFileManager() {
					self.driverStandings = driverStandings
				}
				let driverStandings = await DriversStandingsManager.shared.retrieveDriverStandings()
				if self.driverStandings != driverStandings {
					self.driverStandings = driverStandings
					fileURL.saveDataToFileManager(driverStandings)
				}
			}
		}
	}
}

#Preview {
	DriverStandingsView(seasonId: "2025")
}
