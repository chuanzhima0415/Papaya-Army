//
//  ConstructorStandingsView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/27.
//

import SwiftUI

struct ConstructorStandingsView: View {
	@State private var likedId = UUID()
	@State private var play = false
	@State private var selectedStanding: ConstructorStanding? // 存要 show detail 的车队
	@State var constructorStandings: [ConstructorStanding]?
	var body: some View {
		VStack {
			if let constructorStandings {
				NavigationStack {
					List {
						Section {
							ForEach(0 ..< min(3, constructorStandings.count), id: \.self) { number in
								HStack {
									ConstructorStandingsRowItemView(constructorStanding: constructorStandings[number])
										.swipeActions(edge: .trailing, allowsFullSwipe: false) {
											Button {
												selectedStanding = constructorStandings[number]
											} label: {
												Label("details", systemImage: "arrowshape.up.circle.fill")
											}
										}
								}
							}
						}

						Section {
							ForEach(3 ..< constructorStandings.count, id: \.self) { number in
								HStack {
									ConstructorStandingsRowItemView(constructorStanding: constructorStandings[number])
										.swipeActions(edge: .trailing, allowsFullSwipe: false) {
											Button {
												selectedStanding = constructorStandings[number]
											} label: {
												Label("details", systemImage: "arrowshape.up.circle.fill")
											}
										}
								}
							}
						}
					}
					.sheet(item: $selectedStanding) { standing in
						NavigationStack {
							ConstructorDetailInfoView(constructorId: standing.teamId)
								.presentationDetents([.medium, .large])
								.navigationTitle("\(standing.teamName)")
						}
					}
				}
				.listStyle(.automatic)

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
}
