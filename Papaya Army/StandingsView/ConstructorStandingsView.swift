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
				List {
					ForEach(constructorStandings) { standing in
						ConstructorStandingCardView(position: standing.position, points: standing.points, teamName: standing.teamName)
							.swipeActions(edge: .trailing, allowsFullSwipe: false) {
								Button {
									selectedStanding = standing
								} label: {
									Label("show details", systemImage: "arrowshape.up.circle.fill")
								}
								.tint(.clear)
							}
					}
					.listRowSeparator(.hidden)
					.listRowBackground(Color.clear)
				}
				.sheet(item: $selectedStanding, content: { standing in
					ConstructorDetailInfoView(constructorName: standing.teamName, constructorId: standing.teamId)
						.presentationDetents([.medium, .large])
				})
				.scrollContentBackground(.hidden)
				.safeAreaPadding(.bottom, 130) // 防止最后的那个车队被 tab bar 遮住
			} else {
				LottieView(name: .loading, animationSpeed: 0.5, loopMode: .loop)
			}
		}
		.onAppear {
			Task {
				constructorStandings = await ConstructorStandingsManager.shared.retrieveConstructorStandings()
			}
		}
	}
}

#Preview {
	ConstructorStandingsView()
//	StandingsView(seasonId: "2025")
//	TabsView(seasonId: "2025")
}
