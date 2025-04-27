//
//  SprintRaceResultView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/27.
//

import SwiftUI

struct SprintRaceResultView: View {
	var year: String
	var round: Int
	@State private var sprintRaceResults: [SprintRaceResult]?
	var body: some View {
		NavigationStack {
			if let sprintRaceResults {
				List {
					Section {
						ForEach(0 ..< min(3, sprintRaceResults.count), id: \.self) { number in
							SprintRaceResultRowItemView(position: number + 1, sprintRaceResult: sprintRaceResults[number])
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
						ForEach(3 ..< min(8, sprintRaceResults.count), id: \.self) { number in
							SprintRaceResultRowItemView(position: number + 1, sprintRaceResult: sprintRaceResults[number])
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
						ForEach(8 ..< sprintRaceResults.count, id: \.self) { number in
							SprintRaceResultRowItemView(position: number + 1, sprintRaceResult: sprintRaceResults[number])
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
				.navigationTitle("Sprint Race")
			} else {
				ProgressView("Loading race results ...")
			}
		}
		.onAppear {
			Task {
				sprintRaceResults =  await SprintRaceResultManager.shared.retrieveSprintRaceResults(year: year, round: round)
			}
		}
	}
}

#Preview {
	SprintRaceResultView(year: "2024", round: 5)
}
