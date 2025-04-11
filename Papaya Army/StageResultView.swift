//
//  StageResultView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/11.
//

import SwiftUI

struct StageResultView: View {
	var stageId: String
	@State var stageResult: StageResult?
    var body: some View {
		VStack {
			if let stageResult {
				List(stageResult.competitors, id: \.competitorId) { competitor in
					if let position = competitor.result.position {
						HStack {
							Text("\(position)")
							Text("\(competitor.driverName)")
						}
					}
				}
			} else {
				ProgressView("Loading results...")
			}
		}
		.onAppear {
			Task {
				let stageResultResponse = await StageResultManager.shared.retrieveStageResult(for: stageId)
				self.stageResult = stageResultResponse?.stageResult
			}
		}
    }
}

#Preview {
	StageResultView(stageId: "sr:stage:1107635")
}
