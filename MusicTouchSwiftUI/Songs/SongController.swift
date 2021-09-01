//
//  SongController.swift
//  MusicTouch
//
//  Created by Pedro L. Diaz Montilla on 13/04/2020.
//  Copyright © 2020 Pedro L. Diaz Montilla. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer
import Combine

class SongController {
	
	private var songsRetriever: SongsRetrieverProtocol?
	private var dataStore: DataStoreProtocol
	private var player: PlayerProtocol
	
	
	init(dataStore: DataStoreProtocol, player: PlayerProtocol) {
		self.dataStore        = dataStore
		self.player           = player
		
		self.configureByDefault()
	}
		
	/// Configures the SongController
	/// - Parameters:
	///   - songs: List of songs
	///   - songsRetriever: Songs collection retriever
	func configure(songs: [MTSongData], songsRetriever: SongsRetrieverProtocol) {
		self.songsRetriever = songsRetriever
	}
	
	/// Configure the SongController with default values
	func configureByDefault() {
		self.configure(songs: self.dataStore.songModelList(), songsRetriever: self)
	}
	
	func getSongs() -> [MTSongData] {
		return self.dataStore.songModelList()
	}
	
	func getSongs(byAlbumPersistentID: MPMediaEntityPersistentID) -> [MTSongData] {
		self.dataStore.songsModelList(byAlbumPersistentID: byAlbumPersistentID)
	}

	func getSongs(byArtistPersistentID: MPMediaEntityPersistentID) -> [MTSongData] {
		self.dataStore.songsModelList(byArtistPersistentID: byArtistPersistentID)
	}

	func getSongs(byPlaylistName: String) -> [MTSongData] {
		self.dataStore.songsModelList(byPlaylistName: byPlaylistName)
	}
	
	func getAlbums(byPlaylistName: String) -> [MTAlbumData] {
		return self.dataStore.playlistModelList().filter { $0.name == byPlaylistName }.first?.albums ?? []
	}
	
	func getSongs(byPlaylistName: String, byAlbum: MTAlbumData) -> [MTSongData] {
		return self.dataStore.getSongsModelList(byPlaylist: byPlaylistName, byAlbum: byAlbum)
	}
	
	func getAlbums() -> [MTAlbumData] {
		return self.dataStore.albumModelList()
			.sorted { album1, album2 in
				if (album1.artistName == album2.artistName) { return album1.albumTitle < album2.albumTitle }
				else { return album1.artistName < album2.artistName }
			}
	}
	
	func songsDuration(songs: [MTSongData]) -> String {
		
		let seconds: Int	= songs.map { $0.playTime.seconds }.reduce(0, +)
		var minutes: Int	= songs.map { $0.playTime.minutes }.reduce(0, +)
		var hours: Int		= songs.map { $0.playTime.hours }.reduce(0, +)
		
		let secondsStr: String = String(format: "%02i", seconds % 60)
		minutes = minutes + (seconds / 60)
		
		let minutesStr: String = String(format: "%02i", minutes % 60)
		hours = hours + (minutes / 60)
		
		let hoursStr: String = (hours > 0) ? "\(hours):" : ""
		
		return "\(hoursStr)\(minutesStr):\(secondsStr)"
	}
}

extension SongController: SongsRetrieverProtocol {
	/// Retrieves the Collection of songs in a format to be passed to the player
	/// - Returns: MPMediaItemCollection with all the songs of the list
	func songsCollection() -> MPMediaItemCollection {
		// By default, retrieves the list of all existing songs in the Media Library
		return MPMediaItemCollection(items: self.dataStore.getSongsMediaList())
	}
}
