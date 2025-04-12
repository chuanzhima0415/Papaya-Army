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
	var seasonid: String
	var body: some View {
		NavigationStack {
			if let grandPrixSchedules {
				List(grandPrixSchedules, id: \.id) { grandPrix in
					HStack {
<<<<<<< HEAD
						Text("\(grandPrix.grandPrixName.replacingOccurrences(of: "Grand Prix 2024", with: "GP").replacingOccurrences(of: "2024", with: "GP"))")
=======
						Text("\(grandPrix.grandPrixName.replacingOccurrences(of: "Grand Prix 2025", with: "GP").replacingOccurrences(of: "2025", with: "GP"))")
>>>>>>> 307ed3d (解决了后台从文件读取数据和网络请求数据的一致性问题)
							.font(.headline.weight(.bold))
						NavigationLink {
							StagesScheduleView(grandPrixId: grandPrix.id)
						} label: {
							Text("")
						}
					}
				}
				.navigationTitle("2025")
			} else {
				ProgressView("Loading season schesules...")
			}
		}
		.onAppear {
			Task {
				if let grandPrixSchedules = fileURL.loadDataFromFileManager() {
					self.grandPrixSchedules = grandPrixSchedules
				}
				let grandPrixSchedules = await GrandPrixSchedulesManager.shared.retrieveGrandPrixSchedule(seasonId: seasonid)
				if self.grandPrixSchedules != grandPrixSchedules {
					self.grandPrixSchedules = grandPrixSchedules
					fileURL.saveDataToFileManager(grandPrixSchedules ?? nil)
				}
			}
		}
	}
}

#Preview {
	GrandPrixSchedulesView(seasonid: "sr:stage:1189123")
	// 2024："sr:stage:1107547" 2025: "sr:stage:1189123"
}
