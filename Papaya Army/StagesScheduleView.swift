//
//  StagesView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/11.
//

import SwiftUI

/// 列举某一站的所有 stages
struct StagesScheduleView: View {
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
				self.stagesSchedule = await StageScheduleManager.shared.retrieveStageSchedule(grandPrixId: grandPrixId)
			}
		}
	}
}

#Preview {
	StagesScheduleView(grandPrixId: "sr:stage:1107549")
}
