//
//  DataStore.swift
//  MusicTouch
//
//  Created by Pedro L. Diaz Montilla on 24/3/18.
//  Copyright © 2018 Pedro L. Diaz Montilla. All rights reserved.
//

import Foundation
import MediaPlayer

/// Music Library wrapper to make it easy for the rest of the classes to request music items
class DataStore: DataStoreProtocol {
  
    private var lastArtist:            String?
    private var lastSongByArsitsAlbum: (String, String)?
    private var lastSongByPlaylist:    String?
    
    private var _isDataLoaded: Bool = true
    
    func isDataLoaded() -> Bool { return _isDataLoaded }
        
    // Default size for artwork items
    let size = 250.0
	
	var mediaLibrary: MediaLibraryProtocol

	init(mediaLibrary: MediaLibraryProtocol) {
		self.mediaLibrary = mediaLibrary
    }
}

// MARK: return list
extension DataStore {
    
    /// Returns the songs list stored in the data-store object
    ///
    /// - Returns: songs list
    func songModelList() -> [MTSongData] {
		return self.mediaLibrary.getSongsList().map {
			return MTSongData(mediaItem: $0, mediaLibrary: self.mediaLibrary)
		}
    }
    
    /// Returns the albums list stored in the data-store object
    ///
    /// - Returns: albums list
    func albumModelList() -> [MTAlbumData] {
		return self.mediaLibrary.getAlbumList().map {
			return MTAlbumData(persistentID: $0.albumPersistentID,
							   artistName: $0.albumArtist ?? "",
							   albumTitle: $0.albumTitle ?? "",
							   mediaLibrary: self.mediaLibrary)
		}
    }

	/// Returns the albums list stored in the data-store object
	///
	/// - Returns: albums list
	func albumModelList(byArtistPersistentID: MPMediaEntityPersistentID) -> [MTAlbumData] {
		return self.mediaLibrary.getAlbumsList(byArtistPersistentID: byArtistPersistentID).map {
			return MTAlbumData(persistentID: $0.albumPersistentID,
							   artistName: $0.albumArtist ?? "",
							   albumTitle: $0.albumTitle ?? "",
							   mediaLibrary: self.mediaLibrary)
		}
	}

    /// Returns the playlists list stored in the data-store object
    ///
    /// - Returns: playlists list
    func playlistModelList() -> [MTPlaylistData] {
		return self.mediaLibrary.getPlaylistList().map {
			let name = $0.value(forProperty: MPMediaPlaylistPropertyName) as! String
			let persistentID = self.mediaLibrary.getPlaylistItem(byPlaylistName: name)?.persistentID
			
			return MTPlaylistData(persistentID: persistentID, name: name, mediaLibrary: self.mediaLibrary)
		}
    }
    
    /// Returns the artists list stored in the data-store object
    ///
    /// - Returns: artists list
    func artistModelList() -> [MTArtistData] {
		return self.mediaLibrary.getAlbumArtistList().map {
			return MTArtistData(persistentID: $0.albumArtistPersistentID, name: $0.albumArtist ?? "", mediaLibrary: self.mediaLibrary)
		}
    }
	
	func songsModelList(byAlbumPersistentID: MPMediaEntityPersistentID) -> [MTSongData] {
		return mediaLibrary.getSongsList(byAlbumPersistentID: byAlbumPersistentID).map {
			return MTSongData(mediaItem: $0, mediaLibrary: self.mediaLibrary)
		}
	}

	func songsModelList(byArtistPersistentID: MPMediaEntityPersistentID) -> [MTSongData] {
		return mediaLibrary.getSongsList(byArtistPersistentID: byArtistPersistentID).map {
			return MTSongData(mediaItem: $0, mediaLibrary: self.mediaLibrary)
		}
	}

	func songsModelList(byPlaylistName: String) -> [MTSongData] {
		return mediaLibrary.getSongsList(byPlaylist: byPlaylistName).map {
			return MTSongData(mediaItem: $0, mediaLibrary: self.mediaLibrary)
		}
	}

	/// Gets the list of songs ready to provide them to the player
	/// - Returns: the songs list
	func getSongsMediaList() -> [MPMediaItem] { return mediaLibrary.getSongsList() }
		
	func getSongsModelList(byPlaylist: String, byAlbum: MTAlbumData) -> [MTSongData] {
		return mediaLibrary.getSongsList(byPlaylist: byPlaylist, byAlbumPersistentID: byAlbum.persistentID).map {
			return MTSongData(mediaItem: $0, mediaLibrary: self.mediaLibrary)
		}
	}

}
