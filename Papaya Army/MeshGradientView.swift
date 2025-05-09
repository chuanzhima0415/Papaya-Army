//
//  MeshGradientView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/5/9.
//

import SwiftUI

enum MeshGradientData {
	static var points: [SIMD2<Float>] = [
		[0, 0], [0.33, 0], [0.67, 0], [1, 0],
		[0, 0.33], [0.33, 0.33], [0.7, 0.33], [1, 0.33],
		[0, 0.67], [0.33, 0.67], [0.7, 0.67], [1, 0.67],
		[0, 1], [0.33, 1], [0.7, 1], [1, 1],
	]

	static var colors: [Color] = [
		.black,
		Color(
			red: ConstructorColor.mclaren.red,
			green: ConstructorColor.mclaren.green,
			blue: ConstructorColor.mclaren.blue
		),
	]

	static func randomColors() -> [Color] {
		(0 ..< 16).map { _ in colors.randomElement()! }
	}
}

struct MeshGradientView: View {
	var body: some View {
		MeshGradient(width: 4, height: 4, points: MeshGradientData.points, colors: MeshGradientData.randomColors())
			.ignoresSafeArea()
	}
}

#Preview {
	MeshGradientView()
}
