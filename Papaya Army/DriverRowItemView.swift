//
//  DriverRowItemView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/3/14.
//

import SwiftUI

struct DriverRowItemView: View {
	var position: Int
	var driver: DriverManager.Driver
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
					Text("\(driver.fullName)")
					Text("\(driver.constructor)")
				}
				Spacer()
				VStack {
					Text("\(driver.totalPoints)")
					Text("pts")
				}
			}
			.font(.headline.weight(.medium))
		}
		.padding()
	}
}

#Preview {
	DriverRowItemView(
		position: 1,
		driver: DriverManager.Driver(
			nationality: "British",
			driverNumber: 4,
			fullName: "lando norris",
			constructor: "Mclaren",
			wins: 2,
			standingPos: 1,
			totalPoints: 62
		)
	)
}
