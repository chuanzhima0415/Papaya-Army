//
//  DriverStandingsView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/27.
//

import Lottie
import SwiftUI

struct DriverStandingsView: View {
	private var fileURL: StorageManager.FileManagers<[DriversStanding]> {
		StorageManager.FileManagers(filename: "Driver standings.json")
	}

	var seasonId: String
	@State private var selectedStanding: DriversStanding?
	@State private var driverStandings: [DriversStanding]?
	var body: some View {
		VStack {
			if let driverStandings {
				List {
					ForEach(0 ..< driverStandings.count, id: \.self) { number in
						HStack {
							DriverStandingRowItemView(driverStanding: driverStandings[number])
								.swipeActions(edge: .trailing, allowsFullSwipe: false) {
									Button {
										selectedStanding = driverStandings[number]
									} label: {
										Label("show details", systemImage: "arrowshape.up.circle.fill")
									}
									.tint(.clear)
								}
						}
					}
					.listRowSeparator(.hidden)
					.listRowBackground(Color.clear)
				}
				.sheet(item: $selectedStanding) { standing in
					NavigationStack {
						DriverDetailInfoView(driverDetail: standing.driverDetailInfo)
							.presentationDetents([.medium, .large])
							.navigationTitle("\(standing.driverDetailInfo.firstName) \(standing.driverDetailInfo.lastName)")
					}
				}
				.listStyle(.plain)
				.scrollContentBackground(.hidden)
			} else {
				LottieView(name: .loading, animationSpeed: 0.5, loopMode: .loop)
			}
		}
		.onAppear {
			Task {
				driverStandings = await DriversStandingsManager.shared.retrieveDriverStandings()
			}
		}
	}
}

#Preview {
//	DriverStandingsView(seasonId: "2025")
	StandingsView(seasonId: "2025")
}
