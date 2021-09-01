//
//  DatastoreMock.swift
//  MusicTouch
//
//  Created by Pedro L. Diaz Montilla on 11/6/18.
//  Copyright © 2018 Pedro L. Diaz Montilla. All rights reserved.
//

import Foundation
import MediaPlayer


class MPMediaItemMock: MPMediaItem {
    
    public var _artist: String!
    public var _album: String!
    public var _title: String!
    
    init(artist: String, album: String, title: String) {
        super.init()
        
        self._artist = artist
        self._album  = album
        self._title  = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var albumArtist: String { return _artist }
    override var albumTitle: String { return _album }
    override var title: String { return _title }
    override var artwork: MPMediaItemArtwork? { return nil }
}

class MediaDB {
    public var _artistList:           [MTArtistData] = []
    public var _playlistList:         [MTPlaylistData] = []
    public var _albumList:            [MTAlbumData] = []
    public var _songList:             [MTSongData] = []

    init() {}

}

class DataStoreMock: DataStoreProtocol, MediaLibraryProtocol {
	
    private var _artistList:           [MTArtistData] = []
    private var _playlistList:         [MTPlaylistData] = []
    private var _albumList:            [MTAlbumData] = []
    private var _songList:             [MTSongData] = [] 

    private var _mediaDB = MediaDB()
	
	init() {
		fillCache()
	}
    
    func refreshArtistList() {
        _artistList = _mediaDB._artistList
    }
    
    func refreshPlaylistList() {
        _playlistList = _mediaDB._playlistList
    }
    
    func refreshAlbumList(byArtist: String) {
        if (byArtist.count > 0) {
            _albumList = _mediaDB._albumList.filter { $0.artistName == byArtist }
        }
        else {
            _albumList = _mediaDB._albumList
        }
    }
    
    func refreshSongList(byArtist: String, byAlbum: String) {
        if (byArtist.count == 0 && byAlbum.count == 0) {
            _songList = _mediaDB._songList
        }
        else if (byAlbum.count > 0) {
            _songList = _mediaDB._songList.filter { $0.mediaItem!.albumArtist == byArtist && $0.mediaItem!.albumTitle == byAlbum }
        }
        else {
            _songList = _mediaDB._songList.filter { $0.mediaItem!.albumArtist == byArtist }
        }
    }
    
    func refreshSongList(byPlaylist: String) {
        _songList = [_mediaDB._songList[0], _mediaDB._songList[1]]
    }

    func refreshSongListFromAlbumList() {
        _songList = _mediaDB._songList
    }
    
    func songModelList() -> [MTSongData] {
		self.albumModelList().flatMap { $0.songs }
    }
	
	func songsModelList(byAlbumPersistentID: MPMediaEntityPersistentID) -> [MTSongData] {
		self.albumModelList().flatMap { $0.songs }
	}

	func songsModelList(byArtistPersistentID: MPMediaEntityPersistentID) -> [MTSongData] {
		self.albumModelList().flatMap { $0.songs }
	}

	func songsModelList(byPlaylistName: String) -> [MTSongData] {
		self.albumModelList().flatMap { $0.songs }
	}

    func songCollection() -> MPMediaItemCollection {
        return MPMediaItemCollection(items: [])
    }
    
    func albumModelList() -> [MTAlbumData] {
		return _mediaDB._albumList
    }
	
	func albumModelList(byArtistPersistentID: MPMediaEntityPersistentID) -> [MTAlbumData] {
		return albumModelList()
	}
    
    func playlistModelList() -> [MTPlaylistData] {
		return _mediaDB._playlistList
    }
    
    func artistModelList() -> [MTArtistData] {
		return _mediaDB._artistList
    }
    
    func isDataLoaded() -> Bool {
		return (_mediaDB._playlistList.count > 0) ||
		       (_mediaDB._artistList.count > 0) ||
		       (_mediaDB._albumList.count > 0) ||
		       (_mediaDB._songList.count > 0)
    }
	
	func add(playlist: MTPlaylistData) {
		_mediaDB._playlistList.append(playlist)
	}
	
	func add(artist: MTArtistData) {
		_mediaDB._artistList.append(artist)
	}
	
	func fillCache() {
		_mediaDB._playlistList.append(MTPlaylistData(persistentID: 1, name: "Playlist 1", mediaLibrary: self))
		_mediaDB._playlistList.append(MTPlaylistData(persistentID: 2, name: "Playlist 2", mediaLibrary: self))
		_mediaDB._playlistList.append(MTPlaylistData(persistentID: 3, name: "Playlist 3", mediaLibrary: self))
		_mediaDB._playlistList.append(MTPlaylistData(persistentID: 3, name: "Playlist 4", mediaLibrary: self))
        
		_mediaDB._artistList.append(MTArtistData(persistentID: 4, name: "Artist 1", mediaLibrary: self))
		_mediaDB._artistList.append(MTArtistData(persistentID: 5, name: "Artist 2", mediaLibrary: self))
		_mediaDB._artistList.append(MTArtistData(persistentID: 6, name: "Artist 3", mediaLibrary: self))
		
		_mediaDB._albumList.append(MTAlbumData(persistentID: 7, artistName: "Artist 1", albumTitle: "Album 1", mediaLibrary: self))
		_mediaDB._albumList.append(MTAlbumData(persistentID: 8, artistName: "Artist 1", albumTitle: "Album 2", mediaLibrary: self))
		_mediaDB._albumList.append(MTAlbumData(persistentID: 9, artistName: "Artist 3", albumTitle: "Album 3", mediaLibrary: self))
		_mediaDB._albumList.append(MTAlbumData(persistentID: 10, artistName: "Artist 3", albumTitle: "Album 4", mediaLibrary: self))
		
	}

    
}

extension DataStoreMock {
	func newPlaylist(persistentID: MPMediaEntityPersistentID, playlist: String) {
		_mediaDB._playlistList.append(MTPlaylistData(persistentID: persistentID, name: playlist, mediaLibrary: self))
    }
    
	func newArtist(persistentID: MPMediaEntityPersistentID, artistPermanentID: MPMediaEntityPersistentID, artist: String) {
		_mediaDB._artistList.append(MTArtistData(persistentID: persistentID, name: artist, mediaLibrary: self))
    }    
}


extension DataStoreMock
{
	func getPlaylistList() -> [MPMediaItemCollection] { return [] }
	
	func getAlbumList() -> [MPMediaItem] { return [] }
	
	func getAlbumArtistList() -> [MPMediaItem] { return [] }
	
	func getSongsMediaList() -> [MPMediaItem] { return [] }

	func getPlaylistItem(byPlaylistName: String?) -> MPMediaItem? { return nil }
	
	func getAlbumArtworkImage(byAlbumPersistentID: MPMediaEntityPersistentID) -> UIImage? { return nil }
	
	func getSongItem(byPersistentID: MPMediaEntityPersistentID) -> MPMediaItem? { return nil }
	
	func getSongArtworkImage(byPersistentID: MPMediaEntityPersistentID) -> UIImage? { return nil }
	
	func getAlbumsList(byArtistPersistentID: MPMediaEntityPersistentID) -> [MPMediaItem] { return [] }
	
	func getArtistArtworkImage(byArtistPersistentID: MPMediaEntityPersistentID) -> UIImage? { return nil }
	
	func getSongsList(byPlaylist: String) -> [MPMediaItem] { return [] }
	
	func getPlaylistArtworkImage(byPersistentID: MPMediaEntityPersistentID) -> UIImage? { return nil }
	
	func getSongsList(byPlaylistPersistentID: MPMediaEntityPersistentID) -> [MPMediaItem] { return [] }
	
	func getSongsList(byArtistPersistentID: MPMediaEntityPersistentID) -> [MPMediaItem] { return [] }
	
	func getSongsList(byAlbumPersistentID: MPMediaEntityPersistentID) -> [MPMediaItem] { return [] }
	
	func getSongsList() -> [MPMediaItem] { return [] }
	
	func getSongsList(byPlaylist: String, byAlbumPersistentID: MPMediaEntityPersistentID) -> [MPMediaItem] { return [] }
	
	func getSongsModelList(byPlaylist: String, byAlbum: MTAlbumData) -> [MTSongData] { return [] }

	
}
