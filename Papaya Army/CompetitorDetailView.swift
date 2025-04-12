//
//  DriverDetailView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/5.
//

import SwiftUI

struct CompetitorDetailView: View {
	var fileURL: StorageManager.FileManagers<CompetitorDetailResponse> {
		StorageManager.FileManagers(filename: "\(competitorId).json")
	}
	var competitorId: String
	@State var competitorDetailResponse: CompetitorDetailResponse?
    var body: some View {
		VStack {
			if let competitor = competitorDetailResponse?.competitor, let teams = competitorDetailResponse?.teams, let info = competitorDetailResponse?.info {
				Text("name: \(competitor.driverName)")
				Text("teams: \(teams[0].name)")
				Text("car_number: \(info.carNumber)")
				Text("birth_place: \(info.birthPlace)")
				Text("first pole: \(info.firstPole ?? "--")")
			} else {
				ProgressView("Loading Details...")
			}
		}
		.font(.headline.weight(.bold))
		.onAppear {
			Task {
				if let competitorDetailResponse = fileURL.loadDataFromFileManager() {
					self.competitorDetailResponse = competitorDetailResponse
				}
				let competitorDetailResponse = await CompetitorDetailManager.shared.retrieveCompetitorDetailInfo(competitorId: competitorId)
				if self.competitorDetailResponse != competitorDetailResponse {
					self.competitorDetailResponse = competitorDetailResponse
					fileURL.saveDataToFileManager(competitorDetailResponse)
				}
			}
		}
    }
}

#Preview {
	CompetitorDetailView(competitorId: "sr:competitor:178318")
}
