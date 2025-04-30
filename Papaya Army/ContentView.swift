//
//  ContentView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/3/14.
//

import SwiftUI

struct ContentView: View {
	@State private var isLiked = false
	var body: some View {
		VStack {
			Button {
				isLiked.toggle()
			} label: {
				Text("tap me")
			}
			
			if isLiked {
				LottieView(name: .loading, animationSpeed: 0.5, loopMode: .loop)
					
			}

			Text("hello world")
		}
	}
}

#Preview {
	ContentView()
}
