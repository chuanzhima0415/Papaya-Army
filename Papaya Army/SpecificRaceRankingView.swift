//
//  SpecificRaceRankingView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/9.
//

import SwiftUI

struct SpecificRaceRankingView: View {
	@State var year: Int
	@State var round: Int
	@State var results: [RaceResultManager.RaceResult]
	var body: some View {
		VStack {
			if results.isEmpty {
				ProgressView("Loading...")
			} else {
				List {
					ForEach(results, id: \.position) { result in
						HStack {
							Text("\(result.position)")
							VStack {
								Text("\(result.driverName)")
								Text("\(result.constructor)")
							}
							Spacer()
							Spacer()
							Text("\(result.finishingStatus.isEmpty ? "-" : result.finishingStatus)")
							Spacer()
							if result.position <= 10 {
								VStack {
									Text("+\(result.points)")
									Text("pts")
								}
							}
						}
						.font(.subheadline.weight(.semibold))
					}
				}
			}
		}
		.onAppear {
			RaceResultManager.shared.retrieveSpecificRaceResult(year: year, round: round) { results in
				self.results = results
			}
		}
	}
}

#Preview {
	SpecificRaceRankingView(year: 2024, round: 1, results: [])
}
