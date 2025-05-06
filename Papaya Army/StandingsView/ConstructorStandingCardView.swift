//
//  ContentView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/3/14.
//

import Lottie
import SwiftUI

struct ConstructorStandingCardView: View {
	@State private var play = false
	@State private var isLiked = false
	var position: Int
	var points: Int
	var teamName: String
	var teamColor: (red: Double, green: Double, blue: Double) {
		switch teamName {
		case "Mclaren":
			ConstructorColor.mclaren
		case "Mercedes":
			ConstructorColor.mercedes
		case "Haas":
			ConstructorColor.haas
		case "Red Bull":
			ConstructorColor.red_bull
		case "Rb":
			ConstructorColor.visa_rb
		case "Aston Martin":
			ConstructorColor.aston_martin
		case "Ferrari":
			ConstructorColor.ferrari
		case "Alpine":
			ConstructorColor.alpine
		case "Sauber":
			ConstructorColor.sauber
		default:
			ConstructorColor.williams
		}
	}

	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 50)
				.frame(width: 340, height: 220)
				.foregroundStyle(
					Color(red: teamColor.red, green: teamColor.green, blue: teamColor.blue)
				)
				.shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
			
			VStack {
				HStack {
					Text("\(position < 10 ? "0" + "\(position)" : "\(position)")")
					Spacer()
					Text(teamName)
				}
				.font(.constructorStandingPosFont)
				.foregroundStyle(.white)
				.shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
				.padding(.top, 20)
				.padding(.horizontal, 20)
				
				Image(teamName)
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(height: 75)
					.padding(.bottom)
					.padding(.top)
					.shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
				
				HStack {
					Text("\(points) pts")
						.font(.constructorStandingPosFont)
						.foregroundStyle(.white)
						.shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
						.padding(.bottom, 20)
					
					Spacer()
					
					Button {
						if !isLiked {
							withAnimation {
								isLiked.toggle()
								play = true
							}
						} else {
							withAnimation {
								isLiked.toggle()
							}
						}
					} label: {
						Image(systemName: isLiked ? "heart.fill" : "heart")
							.font(.largeTitle.weight(.semibold))
							.foregroundStyle(isLiked ? Color.lightYellow : .black)
					}
					.buttonStyle(.plain)
					.padding(.bottom, 10)
					.overlay {
						if play {
							LottieView(name: .heartLikes, animationSpeed: 4, contentMode: .scaleAspectFill, play: $play)
								.frame(width: 100, height: 100)
						}
					}
				}
				.padding(.horizontal, 10)
			}
			.frame(width: 318)
		}
	}
}

#Preview {
	ConstructorStandingCardView(position: 1, points: 188, teamName: "Mclaren")
}
