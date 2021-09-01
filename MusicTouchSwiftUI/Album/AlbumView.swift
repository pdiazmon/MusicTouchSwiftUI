//
//  AlbumView.swift
//  MusicTouchSwiftUI
//
//  Created by Pedro L. Diaz Montilla on 13/8/21.
//

import SwiftUI
import MediaPlayer

struct AlbumView: View {

	enum AlbumFilter {
		case byArtist (MTArtistData)
		case all
	}
	var albumsFilter: AlbumView.AlbumFilter
	var controller: MusicTouchController
	
    var body: some View {
		NavigationView {
			AlbumList(albumsFilter: albumsFilter, controller: controller)
		}
		.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
		AlbumView(albumsFilter: .all, controller: MusicTouchController())
    }
}
