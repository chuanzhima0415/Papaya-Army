//
//  ConstructorStandingsView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/27.
//

import SwiftUI

struct ConstructorStandingsView: View {
	@State private var isShortPressed = false // 存有没有短按
	@State private var isLongPressed = false // 存有没有长按
	@State private var pressedID: UUID? // 存哪张卡被按了
	@State private var selectedStanding: ConstructorStanding? // 存要 show detail 的车队
	@State var constructorStandings: [ConstructorStanding]?
	var body: some View {
		VStack {
			if let constructorStandings {
				ScrollView {
					LazyVStack(spacing: 30) {
						ForEach(constructorStandings) { standing in
							ConstructorStandingCardView(position: standing.position, points: standing.points, teamName: standing.teamName)
								.scaleEffect(((isLongPressed || isShortPressed) && pressedID == standing.id) ? 1.1 : 1.0)
								.onLongPressGesture(minimumDuration: 0.2) {
									withAnimation(.spring(response: 0.5, dampingFraction: 2, blendDuration: 0)) {
										isLongPressed = true
										selectedStanding = standing
									}
								} onPressingChanged: { isPressingNow in
									withAnimation(.spring(response: 0.5, dampingFraction: 2, blendDuration: 0)) {
										if isPressingNow {
											isShortPressed = true
											pressedID = standing.id
											DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
												if isLongPressed {
													triggerHapticFeedback()
												}
											}
										} else {
											isShortPressed = false
										}
									}
								}
						}
					}
					.sheet(item: $selectedStanding) {
						withAnimation {
							isLongPressed = false
						}
					} content: { standing in
						withAnimation {
							NavigationStack {
								ConstructorDetailInfoView(constructorId: standing.teamId)
									.presentationDetents([.medium, .large])
									.navigationTitle(standing.teamName)
							}
						}
					}
				}
				.safeAreaPadding(.bottom, 130) // 防止最后的那个车队被 tab bar 遮住
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

	/// 制造手机震动
	func triggerHapticFeedback() {
		let generator = UIImpactFeedbackGenerator(style: .heavy)
		generator.prepare()
		generator.impactOccurred()
	}
}

#Preview {
//	ConstructorStandingsView()
//	StandingsView(seasonId: "2025")
	TabsView(seasonId: "2025")
}
