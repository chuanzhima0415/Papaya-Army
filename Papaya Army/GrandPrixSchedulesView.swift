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
	let color: Color
	var roundIndex: Int
}

struct GrandPrixSchedulesView: View {
	@State private var grandPrixSchedules: [GrandPrixSchedule]? // 每一站的比赛信息
	@State private var dragAmount = CGSize.zero // 拖动的坐标
	@State private var cards: [Card] = [
		Card(offset: 0, id: 0, color: .red, roundIndex: 2),
		Card(offset: 1, id: 1, color: .yellow, roundIndex: 1),
		Card(offset: 2, id: 2, color: .green, roundIndex: 0),
	]
	@State private var draggingCard: Card? // 拖动的卡片
	@State private var pressingCard: Card? // 长按的卡片
	@State private var showSheet = false // 是否弹出 sheet
	private var fileURL: StorageManager.FileManagers<[GrandPrixSchedule]> {
		StorageManager.FileManagers(filename: "GrandPrixSchedules.json")
	}

	private var grandPrixSchedulesCount: Int {
		grandPrixSchedules?.count ?? 0
	}

	var seasonid: String
	var body: some View {
		ZStack {
			if let grandPrixSchedules {
				// ForEach 的 id：
				// 如果 id 不变 → 认为是同一个视图，属性变化会渐变动画
				// 如果 id 变了 → 认为是新视图，删除旧视图，新建一个视图
				ForEach(cards, id: \.id) { card in
					ZStack { // 一张卡片的 view
						Rectangle()
							.fill(card.color)
							.clipShape(.rect(cornerRadius: 20))
						VStack {
							Text("Round: \(card.roundIndex + 1)")
							Text("\(grandPrixSchedules[card.roundIndex].grandPrixName.replacingOccurrences(of: "Grand Prix 2025", with: "GP").replacingOccurrences(of: "2025", with: "GP"))")
						}
						.font(.headline)
						.fontWeight(.bold)
					}
					.frame(width: 250, height: 250)
					.scaleEffect(pressingCard?.id == card.id ? 1.12 : 1)
					.offset(y: card.offset * 8)
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
					.onLongPressGesture(minimumDuration: 0.5) { // 2s 后还在按的处理
						showSheet = true
						pressingCard = card
						triggerHapticFeedback()
					} onPressingChanged: { isPressingNow in // 2s 内的处理
						if isPressingNow {
							withAnimation {
								pressingCard = card
							}
						} else {
							pressingCard = nil
						}
					}
//					.onLongPressGesture(minimumDuration: 2) {
//						withAnimation {
//							pressingCard = card
//						}
//					} onPressingChanged: { isPressingNow in
//						if isPressingNow {
//							withAnimation {
//								pressingCard = card
//							}
//							
//							DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//								if pressingCard?.id == card.id {
//									showSheet = true
//								}
//							}
//						} else {
//							pressingCard = nil
//						}
//					}
				}
			} else {
				ProgressView("Loading...")
			}
		}
		.sheet(isPresented: $showSheet, onDismiss: { // 关闭时的操作
			withAnimation {
				pressingCard = nil
			}
		}, content: { // 弹出时的操作
			NavigationStack {
				if let pressingCard, let grandPrix = grandPrixSchedules?[pressingCard.roundIndex] {
					StagesScheduleView(grandPrixId: grandPrix.id)
						.presentationDetents([.medium, .large])
						.navigationTitle("\(grandPrix.grandPrixName.replacingOccurrences(of: "Grand Prix 2025", with: "GP").replacingOccurrences(of: "2025", with: "GP"))")
				} else {
					ProgressView("Loading...")
				}
			}
		})
		.onAppear {
			Task {
				if let grandPrixSchedules = fileURL.loadDataFromFileManager() {
					self.grandPrixSchedules = grandPrixSchedules
				}
				let grandPrixSchedules = await GrandPrixSchedulesManager.shared.retrieveGrandPrixSchedule(seasonId: seasonid)
				if self.grandPrixSchedules != grandPrixSchedules {
					self.grandPrixSchedules = grandPrixSchedules
					fileURL.saveDataToFileManager(grandPrixSchedules ?? nil)
				}
			}
		}
	}
	
	func triggerHapticFeedback() {
		let generator = UIImpactFeedbackGenerator(style: .heavy)
		generator.prepare()
		generator.impactOccurred()
	}
}

#Preview {
	GrandPrixSchedulesView(seasonid: "sr:stage:1189123")
	// 2024："sr:stage:1107547" 2025: "sr:stage:1189123"
}
