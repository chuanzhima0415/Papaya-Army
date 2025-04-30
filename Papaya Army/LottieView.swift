//
//  LottieView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/27.
//

import SwiftUI
import Lottie

enum LottieAnimations: String {
	case loading = "LoadingAnimation"
	case thumbup = "ThumbupAnimation"
	case heartLikes = "HeartLikes"
}

struct LottieView: UIViewRepresentable {
	let name: LottieAnimations
	let animationSpeed: CGFloat
	let loopMode: LottieLoopMode
	let animationView: LottieAnimationView
	let contentMode: UIView.ContentMode
	@Binding var play: Bool
	
	init(
		name: LottieAnimations,
		animationSpeed: CGFloat = 1,
		loopMode: LottieLoopMode = .playOnce,
		contentMode: UIView.ContentMode = .scaleAspectFit, // 保持动画原本的比例，缩放到整个父视图里，且全部显示完整，不会裁剪、不变形（推荐）
		play: Binding<Bool> = .constant(true) // 视图被创建时希望能立刻跑起来(like loading animations)，所以 true
	) {
		self.name = name
		self.animationView = LottieAnimationView(name: name.rawValue)
		self.animationSpeed = animationSpeed
		self.loopMode = loopMode
		self.contentMode = contentMode
		self._play = play
	}
	
	/// 你在这里new一个 UIView出来，比如 UILabel、LottieAnimationView、UIButton、或者你自己的自定义View。
	func makeUIView(context: Context) -> UIView {
		let view = UIView(frame: .zero)
		view.addSubview(animationView) // view 是父视图，animationView 是子视图
		
		animationView.translatesAutoresizingMaskIntoConstraints = false // 如果你想用 .constraint 这些约束，必须把 translatesAutoresizingMaskIntoConstraints 设成 false
		animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true // 把 animationView 的高度，约束成 跟它的父视图 view 高度一样高。
		animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true // 把 animationView 的宽度，约束成 跟父视图 view 宽度一样宽
		animationView.contentMode = contentMode
		animationView.animationSpeed = animationSpeed
		animationView.loopMode = loopMode
		animationView.play()
		
		return view
	}
	
	/// SwiftUI 检测到 @State、@Binding、Environment 有变化了，就会自动调用这个方法。
	func updateUIView(_ uiView: UIView, context: Context) {
		if play {
			animationView.play { _ in
				play = false
			}
		}
	}
}
