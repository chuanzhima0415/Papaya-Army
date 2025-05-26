//
//  PracticeNResultsRowItemView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/27.
//

import SwiftUI

struct PracticeNResultsRowItemView: View {
	var position: Int
	var practiceNResult: PracticeResult

	var body: some View {
		HStack {
			switch position {
			case 1:
				Image(systemName: "trophy.circle")
					.imageScale(.large)
					.foregroundColor(Color(red: 255 / 255, green: 215 / 255, blue: 0 / 255))
			case 2:
				Image(systemName: "trophy.circle")
					.imageScale(.large)
					.foregroundColor(Color(red: 131 / 255, green: 137 / 255, blue: 150 / 255))
			case 3:
				Image(systemName: "trophy.circle")
					.imageScale(.large)
					.foregroundColor(Color(red: 112 / 255, green: 74 / 255, blue: 7 / 255))
			default:
				Image(systemName: "\(position).circle")
					.imageScale(.large)
			}
			HStack {
				VStack {
					Text("\(practiceNResult.driver.firstName + " " + practiceNResult.driver.lastName)")
				}

				Spacer()

				Text("\(practiceNResult.time ?? "---")")
			}
			.font(.headline.weight(.medium))
		}
		.padding()
	}
}

#Preview {
	PracticeNResultsRowItemView(
		position: 1,
		practiceNResult: PracticeResult(
			driverId: "xxxx",
			teamId: "xxxx",
			time: nil,
			driver: DriverDetailInfo(firstName: "xxxx", lastName: "xxxx", nationality: "xxx", shortName: "xxxx", birthday: "xxxx", number: 1, url: "xxxx")
		)
	)
}
