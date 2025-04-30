//
//  PracticeResultView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/27.
//

import SwiftUI

struct PracticeNResultView: View {
	var year: String
	var round: Int
	var n: Int
	@State var practiceNResults: [PracticeResult]?
	var body: some View {
		NavigationStack {
			if let practiceNResults {
				List {
					Section {
						ForEach(0 ..< min(3, practiceNResults.count), id: \.self) { number in
							PracticeNResultsRowItemView(position: number + 1, practiceNResult: practiceNResults[number])
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
						ForEach(3 ..< practiceNResults.count, id: \.self) { number in
							PracticeNResultsRowItemView(position: number + 1, practiceNResult: practiceNResults[number])
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
				.navigationTitle("Practice\(n)")
			} else {
				LottieView(name: .loading, animationSpeed: 0.5, loopMode: .loop)
			}
		}
		.onAppear {
			Task {
				practiceNResults = await PracticeResultManager.shared.retrievePracticeNResult(year: year, round: round, n: n)
			}
		}
	}
}

#Preview {
	PracticeNResultView(year: "2025", round: 1, n: 2)
}
