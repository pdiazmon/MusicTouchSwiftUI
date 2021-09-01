//
//  AlbumList.swift
//  MusicTouchSwiftUI
//
//  Created by Pedro L. Diaz Montilla on 13/8/21.
//

import SwiftUI

struct AlbumList: View {
	var albumsFilter: AlbumView.AlbumFilter
	
	var controller: MusicTouchController
	
	private var albumsList: [MTAlbumData] {
		var songs: [MTAlbumData]
		
		switch self.albumsFilter {
			case .all:
				songs = self.controller.albumController.getAlbums()
			case let .byArtist(artistData):
				songs = self.controller.albumController.getAlbums(byArtistPersistentID: artistData.persistentID)
		}
		
		return songs
	}
	
    var body: some View {
		List(self.albumsList) { album in
			NavigationLink(destination: SongList(songsFilter: .byAlbum(album), controller: controller)) {
				AlbumRow(album: album)
			}
		}
		.navigationTitle("Albums")
    }
}

struct AlbumList_Previews: PreviewProvider {
    static var previews: some View {
        AlbumList(albumsFilter: .all, controller: MusicTouchController())
    }
}
