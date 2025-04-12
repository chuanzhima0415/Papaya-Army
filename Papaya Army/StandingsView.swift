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
						ForEach(0 ..< min(3, competitors.count), id: \.self) { index in
							if let position = competitors[index].result!.position {
								HStack {
									NavigationLink {
										CompetitorDetailView(competitorId: competitors[index].competitorId)
									} label: {
										HStack {
											CompetitorRowItemView(position: position, competitor: competitors[index])
										}
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
						}
					}
					Section {
						ForEach(3 ..< max(3, competitors.count), id: \.self) { index in
							if let position = competitors[index].result!.position {
								HStack {
									NavigationLink {
										CompetitorDetailView(competitorId: competitors[index].competitorId)
									} label: {
										HStack {
											CompetitorRowItemView(position: position, competitor: competitors[index])
										}
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
				// 优先加载本地的（尽量不要出现圈圈）
				if let competitors = fileURL.loadDataFromFileManager() {
					self.competitors = competitors
				}
				let competitors = await CompetitorStandingsManager.shared.retrieveCompetitorStandings(seasonId: seasonId)
				if self.competitors != competitors {
					self.competitors = competitors
					fileURL.saveDataToFileManager(competitors)
				}
			}
		}
	}
}

#Preview {
	StandingsView(seasonId: "sr:stage:1107547")
}
