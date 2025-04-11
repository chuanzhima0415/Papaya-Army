//
//  SchedulesView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/3/14.
//

import SwiftUI

struct GrandPrixSchedulesView: View {
	private var fileURL: StorageManager.FileManagers<[grandPrixSchedule]> {
		StorageManager.FileManagers(filename: "GrandPrixSchedules.json")
	}
	@State private var grandPrixSchedules: [grandPrixSchedule]?
	private var seasonid = "sr:stage:1107547" // 2024："sr:stage:1107547" 2025: "sr:stage:1189125"
	var body: some View {
		NavigationStack {
			if let grandPrixSchedules {
				List(grandPrixSchedules, id: \.id) { grandPrix in
					HStack {
						Text("\(grandPrix.grandPrixName.replacingOccurrences(of: "Grand Prix 2024", with: "GP").replacingOccurrences(of: "2024", with: "GP"))")
							.font(.headline.weight(.bold))
						NavigationLink {
							StagesScheduleView(grandPrixId: grandPrix.id)
						} label: {
							Text("")
						}

					}
				}
				.navigationTitle("2024 races")
			} else {
				ProgressView("Loading season schesules...")
			}
		}
		.onAppear {
			Task {
				if let schedules = fileURL.loadDataFromFileManager() {
					self.grandPrixSchedules = schedules
				} else {
					grandPrixSchedules = await GrandPrixSchedulesManager.shared.retrieveGrandPrixSchedule(seasonId: seasonid)
					fileURL.saveDataToFileManager(grandPrixSchedules ?? nil)
				}
			}
		}
	}
}

#Preview {
	GrandPrixSchedulesView()
}
