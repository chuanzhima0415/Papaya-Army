//
//  ContentView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/5/4.
//

import Foundation
import SwiftUI

struct ContentView: View {
	init() {
		for familyName in UIFont.familyNames {
			print(familyName)
		}
	}
	var body: some View {
		VStack {
			Text("Hello world")
		}
	}
}

#Preview {
	ContentView()
}
