//
//  ConstructorDetailInfoView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/27.
//

import SwiftUI

struct ConstructorDetailInfoView: View {
	var constructorId: String
	@State private var constructorInfo: ConstructorInfo?
    var body: some View {
		VStack {
			if let constructorInfo {
				Text(constructorInfo.constructorName)
				Text("driver championships: \(constructorInfo.driversChampionships ?? 0)")
			}
		}
		.onAppear {
			Task {
				constructorInfo = await ConstructorInfoManager.shared.retrieveConstructorInfo(teamId: constructorId)?[0]
			}
		}
    }
}

#Preview {
	ConstructorDetailInfoView(constructorId: "mclaren")
}
