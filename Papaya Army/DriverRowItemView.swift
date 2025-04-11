//
//  DriverRowItemView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/3/14.
//

import SwiftUI

struct DriverRowItemView: View {
	var position: Int
	var competitor: Competitor
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
					Text("\(competitor.driverName)")
					Text("\(competitor.team.name)")
				}
				Spacer()
				VStack {
					Text("\(competitor.result.points ?? 0)")
					Text("pts")
				}
			}
			.font(.headline.weight(.medium))
		}
		.padding()
	}
}

#Preview {
	
}
