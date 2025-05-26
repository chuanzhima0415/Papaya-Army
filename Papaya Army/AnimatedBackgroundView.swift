//
//  AnimatedBackgroundView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/5/5.
//

import SwiftUI

// struct AnimatedBackgroundView: View {
//	private let width = 3
//	private let height = 2
//	private let colors = MeshGradientData.randomColors()
//	@State private var change = false
//
//	var body: some View {
//		MeshGradient(width: width, height: height, points: [
//			.init(0.00, 0.00), .init(0.50, 0.00), .init(1.00, 0.00),
//			.init(0.00, 1), .init(change ? 0.21 : 0.78, 1), .init(1.00, 1),
//		], colors: colors, smoothsColors: true)
//			.ignoresSafeArea()
//			.onAppear {
//				withAnimation(.easeInOut(duration: 3).repeatForever()) {
//					change.toggle()
//				}
//			}
//	}
// }

struct AnimatedBackgroundView: View {
	@State private var colors = MeshGradientData.randomColors()
	@State private var isActive = true
	@State private var colorIndex = 0

	private let precomputedColorSchemes: [[Color]] = {
		var schemes = [[Color]]()
		for _ in 0 ..< 6 {
			schemes.append(MeshGradientData.randomColors())
		}
		return schemes
	}()

	private let timerInterval: TimeInterval = 6

	var body: some View {
		MeshGradient(width: 3, height: 2, points: MeshGradientData.points, colors: colors)
			.drawingGroup()
			.onChange(of: isActive) { newValue in
				if newValue {
					startGradientAnimation()
				}
			}
			.onAppear {
				startGradientAnimation()

				NotificationCenter.default.addObserver(
					forName: UIApplication.didEnterBackgroundNotification,
					object: nil,
					queue: .main)
				{ _ in
					isActive = false
				}

				NotificationCenter.default.addObserver(
					forName: UIApplication.willEnterForegroundNotification,
					object: nil,
					queue: .main)
				{ _ in
					isActive = true
				}
			}
			.ignoresSafeArea()
	}

	private func startGradientAnimation() {
		withAnimation(.easeInOut(duration: timerInterval)) {
			colorIndex = (colorIndex + 1) % precomputedColorSchemes.count
			colors = precomputedColorSchemes[colorIndex]

			DispatchQueue.main.asyncAfter(deadline: .now() + timerInterval) {
				if isActive {
					startGradientAnimation()
				}
			}
		}
	}
}

// struct AnimatedBackgroundView: View {
//	@State private var start = UnitPoint(x: 0, y: 0)
//	@State private var end = UnitPoint(x: 1, y: 0)
//	private let noise = 0.1
//	private let colors: [Color] = [
//		.black,
//		Color(red: ConstructorColor.mclaren.red, green: ConstructorColor.mclaren.green, blue: ConstructorColor.mclaren.blue),
//		Color(red: ConstructorColor.mclaren.red, green: ConstructorColor.mclaren.green, blue: ConstructorColor.mclaren.blue)
//	]
//	private let timer = Timer.publish(every: 0.2, on: .main, in: .default).autoconnect()
//
//	var body: some View {
//		LinearGradient(gradient: Gradient(colors: colors), startPoint: start, endPoint: end)
//			.onReceive(timer) { _ in
//				withAnimation(.easeInOut(duration: 2).repeatForever()) {
//					start = UnitPoint(x: Double.random(in: 0 ... 0.4), y: Double.random(in: 0 ... 0.4))
//					end = UnitPoint(x: Double.random(in: 0.5 ... 0.9), y: Double.random(in: 0.5 ... 0.9))
//				}
//			}
//			.ignoresSafeArea(.all)
//			.opacity(0.8)
//			.blendMode(.normal)
//	}
// }

#Preview {
	AnimatedBackgroundView()
}
