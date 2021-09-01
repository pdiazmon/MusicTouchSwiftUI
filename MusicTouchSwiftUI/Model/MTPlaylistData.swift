//
//  Playlist.swift
//  MusicTouch
//
//  Created by Pedro L. Diaz Montilla on 23/3/18.
//  Copyright © 2018 Pedro L. Diaz Montilla. All rights reserved.
//

import Foundation
import MediaPlayer
import UIKit
import SwiftUI

class MTPlaylistData: MTData, Identifiable {
    
	var id = UUID()
    var name: String = ""
	var numberOfSongs: Int { get { return self.getSongsListFromMediaLibrary().count } }
	var songs: [MTSongData] {
		get {
			return self.getSongsListFromMediaLibrary()
					   .map { MTSongData(mediaItem: $0, mediaLibrary: mediaLibrary) }
			           .sorted {
							if ($0.albumTitle() == $1.albumTitle()) { return $0.albumTrackNumber() < $1.albumTrackNumber() }
							else { return $0.albumTitle() < $1.albumTitle() }
						}
			}
	}
	var albums: [MTAlbumData] {
		
		let songs 		= self.getSongsListFromMediaLibrary()
		let allAlbums	= mediaLibrary.getAlbumList()
		
		var albums: [MTAlbumData] {
			
			var albumsSet: Set<MPMediaItem> = []
			
			for song in songs {
				albumsSet.insert(allAlbums.filter { $0.albumPersistentID == song.albumPersistentID }.first! )
			}
			
			return Array(albumsSet.map {
				MTAlbumData(persistentID: $0.albumPersistentID,
							artistName: $0.artist ?? "Artist",
							albumTitle: $0.albumTitle ?? "Album",
							mediaLibrary: self.mediaLibrary)
			})
			.sorted {
				if ($0.artistName == $1.artistName) { return $0.albumTitle < $1.albumTitle }
				else { return $0.artistName < $1.artistName }
			}
		}
		
		return albums
	}
	
    override public var playTime: (hours: Int, minutes: Int, seconds: Int) { get {
        var secs: Int = 0
        for song in songs {
            secs += song.toSeconds()
        }
        return fromSeconds(seconds: secs)
    } }
    
	init(persistentID: MPMediaEntityPersistentID?, name: String, mediaLibrary: MediaLibraryProtocol) {
		super.init(persistentID: persistentID ?? 0, mediaLibrary: mediaLibrary)
		
        self.name = name
    }
	
	/// Gets the playlist title
	/// - Returns: playlist title
    func title() -> String {
        return name
    }
	
	/// Gets the playlist artwork image
	/// - Returns: playlist artwork image
    func image() -> UIImage? {
		return mediaLibrary.getPlaylistArtworkImage(byPersistentID: self.persistentID)
    }
	
	/// Prints the playlist description to the stadard output (for debugging purposes only)
	/// - Parameter offset: numer of heading scpaces
    func describe(offset: Int) {
        print("Playlist: *\(self.name)*")
        for song in self.songs {
            song.describe(offset: offset + 2)
        }
    }

	/// Gets the playlist's song list from the Media Library
	/// - Returns: playlist's songs list in a MPMediaItemCollection object
    func songsCollection() -> MPMediaItemCollection {
		return MPMediaItemCollection(items: getSongsListFromMediaLibrary())
    }

	/// Gets the playlist's song list from the Media Library
	/// - Returns: playlist's songs list
	private func getSongsListFromMediaLibrary() -> [MPMediaItem] {
		return self.mediaLibrary.getSongsList(byPlaylist: self.name)
	}
}
