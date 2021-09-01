//
//  PlayListView.swift
//  MusicTouchSwiftUI
//
//  Created by Pedro L. Diaz Montilla on 11/8/21.
//

import SwiftUI

struct PlayListView: View {
	
	var controller: MusicTouchController
	
    var body: some View {
		NavigationView {
			List {
				ForEach(self.controller.playlistController.getList()) { playlist in
					NavigationLink(destination: SongList(songsFilter: .byPlaylist(playlist.name), controller: controller)) {
						PlaylistRow(playlist: playlist)
					}
				}
			}
			.navigationTitle("Playlists")
		}
		.navigationViewStyle(StackNavigationViewStyle())
    }	
}

struct PlayListView_Previews: PreviewProvider {
    static var previews: some View {
		PlayListView(controller: MusicTouchController(env: .preview))
    }
}


