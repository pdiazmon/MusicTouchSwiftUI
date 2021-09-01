//
//  AlbumController.swift
//  MusicTouchSwiftUI
//
//  Created by Pedro L. Diaz Montilla on 13/8/21.
//

import Foundation
import MediaPlayer

class AlbumController {
	
	private var dataStore: DataStoreProtocol
	private var player: PlayerProtocol?
	
	init(dataStore: DataStoreProtocol, player: PlayerProtocol?) {
		self.dataStore	= dataStore
		self.player		= player		
	}

	func getAlbums() -> [MTAlbumData] {
		return self.dataStore.albumModelList()
	}
	
	func getAlbums(byArtistPersistentID: MPMediaEntityPersistentID) -> [MTAlbumData] {
		return self.dataStore.albumModelList(byArtistPersistentID: byArtistPersistentID)
	}


}
