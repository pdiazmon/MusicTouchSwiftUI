//
//  MusicTouchController.swift
//  MusicTouchSwiftUI
//
//  Created by Pedro L. Diaz Montilla on 11/8/21.
//

import Foundation

class MusicTouchController {
	private var appPlayer: PlayerProtocol
	private var dataStore: DataStoreProtocol
	
	var playlistController: PlaylistController
	var artistController: ArtistController
	var albumController: AlbumController
	var songController: SongController
	var playController: PlayController
	
	enum Environment {
		case real
		case preview
	}
	
	init(env: Environment = .real) {
		self.appPlayer	= PDMPlayer()
		
		switch env {
			case .real:
				self.dataStore = DataStore(mediaLibrary: PDMMediaLibrary())
			case .preview:
				self.dataStore = DataStoreMock()
		}
		
		self.playlistController = PlaylistController(dataStore: self.dataStore, player: self.appPlayer)
		self.artistController	= ArtistController(dataStore: self.dataStore, player: self.appPlayer)
		self.albumController 	= AlbumController(dataStore: self.dataStore, player: self.appPlayer)
		self.songController		= SongController(dataStore: self.dataStore, player: self.appPlayer)
		self.playController		= PlayController(player: self.appPlayer)
	}
}

	
