//
//  ArtistController.swift
//  MusicTouchSwiftUI
//
//  Created by Pedro L. Diaz Montilla on 13/8/21.
//

import Foundation

class ArtistController {
	
	private var dataStore: DataStoreProtocol
	private var player: PlayerProtocol?
	
	init(dataStore: DataStoreProtocol, player: PlayerProtocol?) {
		self.dataStore	= dataStore
		self.player		= player
	}

	func getList() -> [MTArtistData] {
		return self.dataStore.artistModelList()
	}

}
