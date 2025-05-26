//
//  CardView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/5/1.
//

import SwiftUI

struct CardView: View {
	let gpName: String
	
    var body: some View {
		Image(gpName)
    }
}

#Preview {
	CardView(gpName: "Australian GP")
}
