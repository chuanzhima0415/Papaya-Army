//
//  ConstructorStandingsView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/27.
//

import SwiftUI

struct ConstructorStandingSwipeModifier: ViewModifier {
	func body(content: Content) -> some View {
		content
			.swipeActions(edge: .trailing, allowsFullSwipe: false) {
				Button {
					// do something
				} label: {
					Label("Good Job!", systemImage: "hand.thumbsup")
				}
			}
	}
}

extension View {
	func constructorStandingSwipeModifier() -> some View {
		self.modifier(ConstructorStandingSwipeModifier())
	}
}

struct ConstructorStandingsView: View {
	@State var constructorStandings: [ConstructorStanding]?
	var body: some View {
		VStack {
			if let constructorStandings {
				NavigationStack {
					List {
						Section {
							ForEach(0 ..< min(3, constructorStandings.count), id: \.self) { number in
								NavigationLink {
									ConstructorDetailInfoView(constructorId: constructorStandings[number].teamId)
								} label: {
									ConstructorStandingsRowItemView(constructorStanding: constructorStandings[number]).constructorStandingSwipeModifier()
								}
							}
						}
						Section {
							ForEach(3 ..< constructorStandings.count, id: \.self) { number in
								NavigationLink {
									ConstructorDetailInfoView(constructorId: constructorStandings[number].teamId)
								} label: {
									HStack {
										ConstructorStandingsRowItemView(constructorStanding: constructorStandings[number])
									}
								}
								.constructorStandingSwipeModifier()
							}
						}
					}
					.listStyle(.insetGrouped)
				}
			} else {
				ProgressView("Loading constructor standings")
			}
		}
		.onAppear {
			Task {
				self.constructorStandings = await ConstructorStandingsManager.shared.retrieveConstructorStandings()
			}
		}
	}
}

#Preview {
	ConstructorStandingsView()
}
