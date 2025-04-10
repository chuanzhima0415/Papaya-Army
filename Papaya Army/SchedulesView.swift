//
//  SchedulesView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/3/14.
//

import SwiftUI

struct SchedulesView: View {
	private var fileURL: StorageManager.FileManagers<[RaceScheduleManager.RaceSchedule]> {
		StorageManager.FileManagers(filename: "Schedules.json")
	}
	@State private var schedules: [RaceScheduleManager.RaceSchedule] = []
    var body: some View {
		NavigationStack {
			if schedules.isEmpty {
				ProgressView("Loading race schedule...")
			} else {
				List(schedules, id: \.round) { race in
					HStack {
						Text("\(race.round)")
						Text("\(race.raceName)")
						NavigationLink {
							SpecificRaceRankingView(year: 2024, round: race.round, results: [])
						} label: {
							Text("")
						}
					}
				}
			}
		}
		.onAppear {
			if let schedules = fileURL.loadDataFromFileManager() {
				self.schedules = schedules
			} else {
				RaceScheduleManager.shared.retrieveRaceSchedule {
					fileURL.saveDataToFileManager($0)
					self.schedules = $0
				}
			}
		}
    }
}

#Preview {
    SchedulesView()
}
