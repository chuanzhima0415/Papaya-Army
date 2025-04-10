//
//  ScheduleRowItemView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/5.
//

import SwiftUI

struct ScheduleRowItemView: View {
	let raceSchedule: RaceScheduleManager.RaceSchedule
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
	ScheduleRowItemView(
		raceSchedule: RaceScheduleManager
			.RaceSchedule(
				country: "Japan",
				round: 3,
				raceName: "Japanese GP",
				raceTime: RaceScheduleManager
					.RaceTime(
						firstPractice: Date(),
						secondPractice: Date(),
						thirdPractice: Date(),
						sprintQualifying: Date(),
						sprint: Date(),
						qualifying: Date(),
						race: Date()
					),
				circuitName: "Suzuka Circuit"
			)
	)
}
