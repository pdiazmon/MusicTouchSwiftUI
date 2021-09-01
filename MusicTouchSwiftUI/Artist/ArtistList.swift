//
//  ArtistList.swift
//  MusicTouchSwiftUI
//
//  Created by Pedro L. Diaz Montilla on 13/8/21.
//

import SwiftUI

struct ArtistList: View {
	var controller: MusicTouchController
	
	private var artistList: [MTArtistData] {
		self.controller.artistController.getList()
	}
	
    var body: some View {
		List() {
			ForEach(self.artistList, id:\.id) { artist in
				NavigationLink(destination: AlbumList(albumsFilter: .byArtist(artist), controller: controller)) {
					ArtistRow(artist: artist)
				}
			}
		}
		.navigationTitle("Artists")
    }
}

struct ArtistList_Previews: PreviewProvider {
    static var previews: some View {
		ArtistList(controller: MusicTouchController())
    }
}
