//
//  StagesView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/11.
//

import SwiftUI

/// 列举某一站的所有 stages
struct StagesScheduleView: View {
	private var fileURL: StorageManager.FileManagers<[StageSchedule]> {
		StorageManager.FileManagers(filename: "\(grandPrixId).json")
	}
	var grandPrixId: String
	@State var stagesSchedule: [StageSchedule]?
	var body: some View {
		NavigationStack {
			if let stagesSchedule {
				List(stagesSchedule, id: \.stageId) { stageSchedule in
					HStack {
						Text("\(stageSchedule.name)")
							.font(.subheadline.weight(.semibold))
						NavigationLink("") {
							StageResultView(stageId: stageSchedule.stageId)
						}
					}
				}
			} else {
				ProgressView("Loading stages...")
			}
		}
		.onAppear {
			Task {
				if let stagesSchedule = fileURL.loadDataFromFileManager() {
					self.stagesSchedule = stagesSchedule
				}
				let stagesSchedule = await StageScheduleManager.shared.retrieveStageSchedule(grandPrixId: grandPrixId)
				if self.stagesSchedule != stagesSchedule {
					self.stagesSchedule = stagesSchedule
					fileURL.saveDataToFileManager(self.stagesSchedule)
				}
			}
		}
	}
}

#Preview {
	StagesScheduleView(grandPrixId: "sr:stage:1107549")
}
