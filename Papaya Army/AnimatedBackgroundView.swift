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
	private let noise = 0.1
	private let colors: [Color] = [
		.black,
		Color(red: ConstructorColor.mclaren.red, green: ConstructorColor.mclaren.green, blue: ConstructorColor.mclaren.blue),
		Color(red: ConstructorColor.mclaren.red, green: ConstructorColor.mclaren.green, blue: ConstructorColor.mclaren.blue)
	]
	private let timer = Timer.publish(every: 0.2, on: .main, in: .default).autoconnect()

	var body: some View {
		LinearGradient(gradient: Gradient(colors: colors), startPoint: start, endPoint: end)
			.onReceive(timer) { _ in
				withAnimation(.easeInOut(duration: 2).repeatForever()) {
					start = UnitPoint(x: Double.random(in: 0 ... 0.4), y: Double.random(in: 0 ... 0.4))
					end = UnitPoint(x: Double.random(in: 0.5 ... 0.9), y: Double.random(in: 0.5 ... 0.9))
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
