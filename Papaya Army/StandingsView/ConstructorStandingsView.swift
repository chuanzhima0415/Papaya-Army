//
//  ConstructorStandingsView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/27.
//

import SwiftUI

struct ConstructorStandingsView: View {
	@State private var selectedStanding: ConstructorStanding? // 存要 show detail 的车队
	@State var constructorStandings: [ConstructorStanding]?
	var body: some View {
		VStack {
			if let constructorStandings {
				NavigationStack {
					List(constructorStandings) { standing in
						ConstructorStandingCardView(position: standing.position, points: standing.points, teamName: standing.teamName)
							.listRowSeparator(.hidden)
							.swipeActions(edge: .trailing, allowsFullSwipe: false) {
								Button {
									selectedStanding = standing
								} label: {
									Label("For details", systemImage: "info.bubble.fill")
								}
							}
					}
					.listStyle(.plain)
					.sheet(item: $selectedStanding) { standing in
						NavigationStack {
							ConstructorDetailInfoView(constructorId: standing.teamId)
								.presentationDetents([.medium, .large])
								.navigationTitle(standing.teamName)
						}
					}
				}
			} else {
				LottieView(name: .loading, animationSpeed: 0.5, loopMode: .loop)
			}
		}
		.padding()
		.onAppear {
			Task {
				constructorStandings = await ConstructorStandingsManager.shared.retrieveConstructorStandings()
			}
		}
	}
}

#Preview {
	ConstructorStandingsView()
}
