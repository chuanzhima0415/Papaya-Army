//
//  DriverRowItemView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/3/14.
//

import SwiftUI

struct DriverStandingRowItemView: View {
	var driverStanding: DriversStanding
	var body: some View {
		HStack {
			switch driverStanding.position {
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
				Image(systemName: "\(driverStanding.position).circle")
					.imageScale(.large)
			}
			HStack {
				VStack {
					Text("\(driverStanding.driverDetailInfo.firstName + " " + driverStanding.driverDetailInfo.lastName)")
				}
				Spacer()
				VStack {
					Text("\(driverStanding.points)")
					Text("pts")
				}
			}
			.font(.headline.weight(.medium))
		}
		.padding()
	}
}

#Preview {
	DriverStandingRowItemView(
		driverStanding: DriversStanding(
			driverId: "xxxx",
			teamId: "xxxx",
			points: 120,
			position: 1,
			driverDetailInfo: DriverDetailInfo(
				firstName: "xxx",
				lastName: "xxx",
				nationality: "xxx",
				shortName: "xxx",
				birthday: "xxx-xxx-xxx",
				number: 4,
				url: "xxxx"
			)
		)
	)
}
