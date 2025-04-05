//
//  SchedulesView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/3/14.
//

import SwiftUI

struct SchedulesView: View {
	@State private var races: [Race] = []
    var body: some View {
		NavigationStack {
			if races.isEmpty {
				ProgressView("Loading race schedule...")
			} else {
				List(races, id: \.round) { race in
					HStack {
						Text("\(race.round)")
						Text("\(race.raceName)")
						NavigationLink {
							SpecificRoundRankingView(year: 2024, round: race.round)
						} label: {
							Text("")
						}
					}
				}
			}
		}
		.onAppear {
			RaceManager.shared.retrieveRaceSchedule { races in
				self.races = races
			}
		}
    }
}

#Preview {
    SchedulesView()
}
