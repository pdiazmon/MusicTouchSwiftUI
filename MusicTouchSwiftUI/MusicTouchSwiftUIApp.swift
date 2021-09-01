//
//  MusicTouchSwiftUIApp.swift
//  MusicTouchSwiftUI
//
//  Created by Pedro L. Diaz Montilla on 11/8/21.
//

import SwiftUI

@main
struct MusicTouchSwiftUIApp: App {
	
	// Following app attributes are shared within the app
	var controller = MusicTouchController()
	
    var body: some Scene {
        WindowGroup {
			MainView(controller: controller)
        }
    }
}
