//
//  MeshGradientView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/5/9.
//

import SwiftUI

enum MeshGradientData {
	static var points: [SIMD2<Float>] = [
		.init(0.00, 0.00),.init(0.50, 0.00),.init(1.00, 0.00),
		.init(0.00, 1.00),.init(0.50, 1.00),.init(1.00, 1.00)
	]

	static var colors: [Color] = [
		.black,
		.black,
		Color(red: ConstructorColor.mclaren.red, green: ConstructorColor.mclaren.green, blue: ConstructorColor.mclaren.blue),
		Color(red: ConstructorColor.mclaren.red, green: ConstructorColor.mclaren.green, blue: ConstructorColor.mclaren.blue),
		Color(red: ConstructorColor.mclaren.red, green: ConstructorColor.mclaren.green, blue: ConstructorColor.mclaren.blue)
	]

	static func randomColors() -> [Color] {
		(0 ..< 6).map { _ in colors.randomElement()! }
	}
}

struct MeshGradientView: View {
	var body: some View {
		MeshGradient(width: 3, height: 4, points: MeshGradientData.points, colors: MeshGradientData.randomColors())
			.ignoresSafeArea()
	}
}

#Preview {
	MeshGradientView()
}
