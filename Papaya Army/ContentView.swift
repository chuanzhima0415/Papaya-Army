//
//  ContentView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/3/14.
//

import SwiftUI

struct ContentView: View {
	@State private var fp2Results: [SprintRaceResult]?
	var body: some View {
		VStack {
			Text("hello World")
		}
		.onAppear {
			Task {
				fp2Results = await SprintRaceResultManager.shared.retrieveSprintRaceResults(year: "2024", round: 5)
			}
		}
	}
}

#Preview {
	ContentView()
}
