//
//  StandingsView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/3/14.
//

import SwiftUI

enum Standings: String, CaseIterable, Identifiable {
	var id: String {
		self.rawValue
	}

	case drivers
	case constructors
}

struct StandingsView: View {
	var seasonId: String
	@State private var selectedStandings: Standings = .drivers
	var body: some View {
		NavigationStack {
			NavigationStack {
				Text("Standings")
					.font(.title.weight(.bold))
					.ignoresSafeArea()
				
				Picker("Choose you standings", selection: $selectedStandings.animation()) {
					ForEach(Standings.allCases) {
						Text($0.rawValue.capitalized).tag($0)
					}
				}
				.pickerStyle(.segmented)
				.padding()
				.frame(width: 300)
			}
			.padding(.top, 20)
			
			Spacer()
			
			switch selectedStandings {
			case .drivers:
				DriverStandingsView(seasonId: seasonId)
			case .constructors:
				ConstructorStandingsView()
			}
		}
	}
}

#Preview {
	StandingsView(seasonId: "2025")
}
