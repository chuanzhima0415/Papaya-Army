//
//  SprintQualifyingView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/27.
//

import SwiftUI

struct SprintQualifyingResultView: View {
	var year: String
	var round: Int
	@State var sprintQualifyingResults: [SprintQualifyingResult]?
	var body: some View {
		NavigationStack {
			if let sprintQualifyingResults {
				List {
					Section {
						ForEach(0 ..< min(3, sprintQualifyingResults.count), id: \.self) { number in
							SprintQualifyingResultRowItemView(
								position: number + 1,
								sprintQualifyingResult: sprintQualifyingResults[number]
							)
						}
						.swipeActions(edge: .trailing, allowsFullSwipe: false) {
							Button {
								// do something
							} label: {
								Label("Good Job!", systemImage: "hand.thumbsup")
							}
						}
					}
					Section {
						ForEach(3 ..< sprintQualifyingResults.count, id: \.self) { number in
							SprintQualifyingResultRowItemView(
								position: number + 1,
								sprintQualifyingResult: sprintQualifyingResults[number]
							)
						}
						.swipeActions(edge: .trailing, allowsFullSwipe: false) {
							Button {
								// do something
							} label: {
								Label("Good Job!", systemImage: "hand.thumbsup")
							}
						}
					}
				}
				.navigationTitle("Sprint Qualifying")
			} else {
				ProgressView("Loading Sprint Qualifying results")
			}
		}
		.onAppear {
			Task {
				sprintQualifyingResults = await SprintQualifyingResultManager.shared
					.retrieveSprintQualifyingResult(year: year, round: round)
			}
		}
	}
}

#Preview {
	SprintQualifyingResultView(year: "2024", round: 5)
}
