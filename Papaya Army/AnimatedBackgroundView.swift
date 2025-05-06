//
//  AnimatedBackgroundView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/5/5.
//

import SwiftUI

struct AnimatedBackgroundView: View {
	@State private var start = UnitPoint(x: 0, y: 0)
	@State private var end = UnitPoint(x: 1, y: 0)
	private let noise = 0.05
	private let colors: [Color] = [
		.black,
		Color(red: ConstructorColor.mclaren.red, green: ConstructorColor.mclaren.green, blue: ConstructorColor.mclaren.blue)
	]
	private let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()

	var body: some View {
		LinearGradient(gradient: Gradient(colors: colors), startPoint: start, endPoint: end)
			.onReceive(timer) { _ in
				withAnimation(.easeInOut(duration: 20).repeatForever()) {
					start = UnitPoint(x: 0.2 + Double.random(in: -noise ... noise), y: 0.2 + Double.random(in: -noise ... noise))
					end = UnitPoint(x: 0.8 + Double.random(in: -noise ... noise), y: 0.8 + Double.random(in: -noise ... noise))
				}
			}
			.ignoresSafeArea(.all)
			.opacity(0.8)
			.blendMode(.normal)
	}
}

#Preview {
	AnimatedBackgroundView()
}
