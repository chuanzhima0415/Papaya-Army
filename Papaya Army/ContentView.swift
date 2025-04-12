//
//  ContentView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/3/14.
//

import SwiftUI

struct ContentView: View {
	var seasonId: String
	var body: some View {
		HStack {
			Text("Papaya Army x 10")
				.font(.largeTitle)
				.bold()
				.fontWeight(.black)
				.italic()
				.foregroundStyle(.linearGradient(
					stops: [Gradient.Stop(color: .orange, location: 0.48), Gradient.Stop(color: .black, location: 0.5)],
					startPoint: .bottomLeading,
					endPoint: .topTrailing
				))

			Image(systemName: "trophy.fill")
				.imageScale(.large)
				.symbolRenderingMode(.multicolor)
				.foregroundStyle(.linearGradient(
					stops: [Gradient.Stop(color: .orange, location: 0.46), Gradient.Stop(color: .black, location: 0.5)],
					startPoint: .bottomLeading,
					endPoint: .topTrailing
				))
		}
		.padding()
	}
}

#Preview {
	ContentView(seasonId: "sr:stage:1189123")
}
