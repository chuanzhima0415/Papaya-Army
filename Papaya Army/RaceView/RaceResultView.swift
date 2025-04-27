//
//  RaceResultView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/27.
//

import SwiftUI

struct RaceResultView: View {
	var year: String
	var round: Int
	@State private var raceResults: [RaceResult]?
    var body: some View {
		NavigationStack {
			if let raceResults {
				List {
					Section {
						ForEach(0 ..< min(3, raceResults.count), id: \.self) { number in
							RaceResultRowItemView(position: number + 1, raceResult: raceResults[number])
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
						ForEach(3 ..< min(10, raceResults.count), id: \.self) { number in
							RaceResultRowItemView(position: number + 1, raceResult: raceResults[number])
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
						ForEach(10 ..< raceResults.count, id: \.self) { number in
							RaceResultRowItemView(position: number + 1, raceResult: raceResults[number])
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
				.navigationTitle("Race")
			} else {
				ProgressView("Loading race results ...")
			}
		}
		.onAppear {
			Task {
				raceResults =  await RaceResultManager.shared.retrieveCertainRaceResult(year: year, round: round)
			}
		}
    }
}

#Preview {
	RaceResultView(year: "2025", round: 1)
}
