//
//  ArtistView.swift
//  MusicTouchSwiftUI
//
//  Created by Pedro L. Diaz Montilla on 13/8/21.
//

import SwiftUI

struct ArtistView: View {
	var controller: MusicTouchController
	
	var body: some View {
		NavigationView {
			ArtistList(controller: controller)
		}
		.navigationViewStyle(StackNavigationViewStyle())
	}
}

struct ArtistView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistView(controller: MusicTouchController())
    }
}
