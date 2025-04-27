//
//  QualifyingResultView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/27.
//

import SwiftUI

struct QualifyingResultView: View {
	var year: String
	var round: Int
	@State var qualifyingResults: [QualifyingResult]?
    var body: some View {
		NavigationStack {
			if let qualifyingResults {
				List {
					Section {
						ForEach(0 ..< min(3, qualifyingResults.count), id: \.self) { number in
							QualifyingResultRowItemView(position: number + 1, qualifyingResult: qualifyingResults[number])
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
						ForEach(3 ..< min(10, qualifyingResults.count), id: \.self) { number in
							QualifyingResultRowItemView(position: number + 1, qualifyingResult: qualifyingResults[number])
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
				.navigationTitle("Qualifying")
			} else {
				ProgressView("Loading Qualifying results")
			}
		}
		.onAppear {
			Task {
				qualifyingResults = await QualifyingResultManager.shared.retrieveQualifyingResults(year: year, round: round)
			}
		}
    }
}

#Preview {
	QualifyingResultView(year: "2025", round: 1)
}
