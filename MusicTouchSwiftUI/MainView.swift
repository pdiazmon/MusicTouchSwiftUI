//
//  MainView.swift
//  MusicTouchSwiftUI
//
//  Created by Pedro L. Diaz Montilla on 11/8/21.
//

import SwiftUI

struct MainView: View {
	
	var controller: MusicTouchController
	
    var body: some View {
		TabView {
			PlayListView(controller: controller)
				.tabItem {
					Label("Playlists", systemImage: "list.bullet")
					}
			ArtistView(controller: controller)
				.tabItem {
					Label("Artists", systemImage: "person.3")
				}
			AlbumView(albumsFilter: .all, controller: controller)
				.tabItem {
					Label("Albums", systemImage: "opticaldisc")
				}
			SongView(songsFilter: .all, controller: controller)
				.tabItem {
					Label("Songs", systemImage: "music.note")
				}
		}
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
		MainView(controller: MusicTouchController(env: .preview))
    }
}
