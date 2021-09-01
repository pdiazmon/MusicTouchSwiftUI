//
//  Datastore.swift
//  MusicTouch
//
//  Created by Pedro L. Diaz Montilla on 11/6/18.
//  Copyright © 2018 Pedro L. Diaz Montilla. All rights reserved.
//

import Foundation
import MediaPlayer

protocol DataStoreProtocol {
	
	// ----- MODEL
	
    func songModelList() -> [MTSongData]
	
	func songsModelList(byAlbumPersistentID: MPMediaEntityPersistentID) -> [MTSongData]
	
	func songsModelList(byArtistPersistentID: MPMediaEntityPersistentID) -> [MTSongData]
	
	func songsModelList(byPlaylistName: String) -> [MTSongData]
	
	func getSongsModelList(byPlaylist: String, byAlbum: MTAlbumData) -> [MTSongData]
    
    func albumModelList() -> [MTAlbumData]
	
	func albumModelList(byArtistPersistentID: MPMediaEntityPersistentID) -> [MTAlbumData]
    
    func playlistModelList() -> [MTPlaylistData]
    
    func artistModelList() -> [MTArtistData]
    
    func isDataLoaded() -> Bool
	
	// ------ MEDIA
	
	func getSongsMediaList() -> [MPMediaItem]
}
