//
//  StandingsView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/3/14.
//

import SwiftUI

struct StandingsView: View {
	private var fileURL: StorageManager.FileManagers<[Competitor]> {
		StorageManager.FileManagers(filename: "Standings.json")
	}
	var seasonId: String
	@State private var competitors: [Competitor]?
	var body: some View {
		NavigationStack {
			if let competitors {
				List {
					Section {
						ForEach(0 ..< min(3, competitors.count), id: \.self) {
							if let position = competitors[$0].result!.position {
								CompetitorRowItemView(position: position, competitor: competitors[$0])
									.swipeActions(edge: .trailing, allowsFullSwipe: false) {
										Button {
												// do something
										} label: {
											Label("Good Job!", systemImage: "hand.thumbsup")
										}
										Button {
												// Jump into driver details
										} label: {
											Label("Jump to details", systemImage: "info.bubble")
										}
										
									}
							}
						}
					}
					Section {
						ForEach(3 ..< max(3, competitors.count), id: \.self) {
							if let position = competitors[$0].result!.position {
								CompetitorRowItemView(position: position, competitor: competitors[$0])
									.swipeActions(edge: .trailing, allowsFullSwipe: false) {
										Button {
												// do something
										} label: {
											Label("Good Job!", systemImage: "hand.thumbsup")
										}
									}
							}
						}
					}
				}
				.listStyle(.insetGrouped)
				.navigationTitle("Standings")
			} else {
				ProgressView("Loading Standings...")
			}
		}
		.onAppear {
			Task {
				if let competitors = fileURL.loadDataFromFileManager() {
					self.competitors = competitors
				} else {
					self.competitors = await CompetitorStandingsManager.shared.retrieveCompetitorStandings(seasonId: seasonId)
					fileURL.saveDataToFileManager(self.competitors)
				}
			}
		}
	}
}

#Preview {
	StandingsView(seasonId: "sr:stage:1107547")
}
