//
//  PlaylistController.swift
//  MusicTouch
//
//  Created by Pedro L. Diaz Montilla on 13/04/2020.
//  Copyright © 2020 Pedro L. Diaz Montilla. All rights reserved.
//

import Foundation
//import UIKit
//import Combine

class PlaylistController {
	
	private var dataStore: DataStoreProtocol
	private var player: PlayerProtocol?
	
	init(dataStore: DataStoreProtocol, player: PlayerProtocol?) {
		self.dataStore        = dataStore
		self.player           = player
	}
	
	func getList() -> [MTPlaylistData] {
		return self.dataStore.playlistModelList()
	}

}
