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
									Button {
										if !self.constructorStandings![number].isLiked {
											self.constructorStandings![number].isLiked.toggle()
											likedId = self.constructorStandings![number].id
											play = true
										} else {
											withAnimation {
												self.constructorStandings![number].isLiked.toggle()
												likedId = UUID()
											}
										}
									} label: {
										Label("", systemImage: self.constructorStandings![number].isLiked ? "heart.fill" : "heart")
											.foregroundStyle(Color(red: 225 / 255, green: 135 / 255, blue: 0))
									}
									.buttonStyle(.plain)
									.overlay(alignment: .center) {
										if self.constructorStandings![number].id == likedId {
											LottieView(name: .heartLikes, animationSpeed: 4, contentMode: .scaleAspectFill, play: $play)
												.frame(width: 80, height: 80)
												.allowsHitTesting(false)
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
									Button {
										if !self.constructorStandings![number].isLiked {
											self.constructorStandings![number].isLiked.toggle()
											likedId = self.constructorStandings![number].id
											play = true
										} else {
											withAnimation {
												self.constructorStandings![number].isLiked.toggle()
												likedId = UUID()
											}
										}
									} label: {
										Label("", systemImage: self.constructorStandings![number].isLiked ? "heart.fill" : "heart")
											.foregroundStyle(Color(red: 225 / 255, green: 135 / 255, blue: 0))
									}
									.buttonStyle(.plain)
									.overlay(alignment: .center) {
										if self.constructorStandings![number].id == likedId {
											LottieView(name: .heartLikes, animationSpeed: 4, contentMode: .scaleAspectFill, play: $play)
												.frame(width: 80, height: 80)
												.allowsHitTesting(false)
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
