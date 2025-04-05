//
//  SpecificRoundRankingView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/5.
//

import SwiftUI

struct SpecificRoundRankingView: View {
	@State private var drivers: [Driver] = []
	var year: Int
	var round: Int
    var body: some View {
		VStack {
			if drivers.isEmpty {
				ProgressView("Loading...")
			} else {
				List {
					ForEach(drivers, id: \.fullName) { driver in
						HStack {
							Text("\(driver.position)")
							VStack {
								Text("\(driver.fullName)")
								Text("\(driver.team)")
							}
							Spacer()
							Spacer()
							Text("\(driver.finishedStatus.isEmpty ? "-" : driver.finishedStatus)")
							Spacer()
							if driver.position <= 10 {
								VStack {
									Text("+\(driver.points)")
									Text("pts")
								}
							}
						}
						.font(.subheadline.weight(.semibold))
					}
				}
			}
		}
		.onAppear {
			RaceManager.shared.retrieveSpecificRaceResult(year: year, round: round) { drivers in
				self.drivers = drivers
			}
		}
    }
}

#Preview {
	SpecificRoundRankingView(year: 2024, round: 1)
}
