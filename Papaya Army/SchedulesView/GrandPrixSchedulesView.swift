//
//  SchedulesView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/3/14.
//

import SwiftUI
import UIKit

struct Card: Identifiable {
	var offset: Double
	let id: Int
	var roundIndex: Int
}

struct GrandPrixSchedulesView: View {
	@State private var grandPrixSchedules: [GrandPrixSchedule]? // 每一站的比赛信息
	@State private var dragAmount = CGSize.zero // 拖动的坐标
	@State private var cards: [Card] = [
		Card(offset: 0, id: 0, roundIndex: 3),
		Card(offset: 1, id: 1, roundIndex: 2),
		Card(offset: 2, id: 2, roundIndex: 1),
		Card(offset: 3, id: 3, roundIndex: 0),
	]
	@State private var draggingCard: Card? // 拖动的卡片
	@State private var pressingCard: Card? // 长按的卡片
	@State private var showingSheet = false // 是否弹出 sheet
	private var fileURL: StorageManager.FileManagers<[GrandPrixSchedule]> {
		StorageManager.FileManagers(filename: "GrandPrixSchedules.json")
	}

	private var grandPrixSchedulesCount: Int {
		grandPrixSchedules?.count ?? 0
	}

	var seasonid: String
	var body: some View {
		VStack {
			Spacer()
			Spacer()

			ZStack {
				if let grandPrixSchedules {
					// ForEach 的 id：
					// 如果 id 不变 → 认为是同一个视图，属性变化会渐变动画
					// 如果 id 变了 → 认为是新视图，删除旧视图，新建一个视图
					ForEach(cards, id: \.id) { card in
						CardView(gpName: grandPrixSchedules[card.roundIndex].gpName)
							.frame(width: 280, height: 250)
							.scaleEffect(pressingCard?.id == card.id ? 1.12 : 1)
							.shadow(radius: 10)
							.offset(y: card.offset * 5)
							.offset(draggingCard?.id == card.id ? dragAmount : .zero)
							.gesture(
								DragGesture()
									.onChanged {
										dragAmount = $0.translation
										draggingCard = card
									}
									.onEnded { _ in
										withAnimation {
											dragAmount = .zero
											draggingCard = nil

											let cardsCount = cards.count
											var topCard = cards.removeLast()
											topCard.roundIndex = (topCard.roundIndex + cardsCount) % grandPrixSchedulesCount
											cards.insert(topCard, at: cards.startIndex)

											// 改变每张卡片的 offset
											for index in cards.indices {
												cards[index].offset = Double(index) + 1
											}
										}
									}
							)
							.onLongPressGesture(minimumDuration: 0.2) { // 长按松开后的处理
								withAnimation {
									pressingCard = card
									showingSheet = true
								}
							} onPressingChanged: { isPressingNow in // 从不按到按走一次，从按到不按走一次，只要按压变了，都会走的
								withAnimation(.spring(response: 0.5, dampingFraction: 2, blendDuration: 0)) {
									if isPressingNow {
										pressingCard = card
										DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
											triggerHapticFeedback()
										}
									} else {
										pressingCard = nil
									}
								}
							}
					}
				} else {
					LottieView(name: .loading, animationSpeed: 0.5, loopMode: .loop)
				}
			}
			.sheet(isPresented: $showingSheet, onDismiss: { // 关闭时的操作
				withAnimation {
					pressingCard = nil
				}
			}, content: { // 弹出时的操作
				NavigationStack {
					if let pressingCard, let grandPrix = grandPrixSchedules?[pressingCard.roundIndex] {
						StagesScheduleView(gpSchedule: grandPrix)
							.presentationDetents([.medium, .large])
					} else {
						LottieView(name: .loading, animationSpeed: 0.5, loopMode: .loop)
					}
				}
			})
			.onAppear {
				Task {
					if let grandPrixSchedules = fileURL.loadDataFromFileManager() {
						self.grandPrixSchedules = grandPrixSchedules
					}
					grandPrixSchedules = await GrandPrixSchedulesManager.shared.retrieveGrandPrixSchedules()
					if grandPrixSchedules != self.grandPrixSchedules {
						self.grandPrixSchedules = grandPrixSchedules
						fileURL.saveDataToFileManager(grandPrixSchedules ?? nil)
					}
				}
			}

			Spacer()

			Button {
				reshuffleCard()
			} label: {
				VStack {
					Image(systemName: "arrow.clockwise.circle.fill")
				}
			}
			.font(.system(size: 70))
			.padding()
		}
	}

	/// 制造手机震动
	func triggerHapticFeedback() {
		let generator = UIImpactFeedbackGenerator(style: .heavy)
		generator.prepare()
		generator.impactOccurred()
	}

	/// 重置卡片
	func reshuffleCard() {
		withAnimation {
			cards = [
				Card(offset: 0, id: 0, roundIndex: 3),
				Card(offset: 1, id: 1, roundIndex: 2),
				Card(offset: 2, id: 2, roundIndex: 1),
				Card(offset: 3, id: 3, roundIndex: 0),
			]
		}
	}
}

#Preview {
	GrandPrixSchedulesView(seasonid: "2025")
//	TabsView(seasonId: "2025")
}
