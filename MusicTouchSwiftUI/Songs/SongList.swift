//
//  SongList.swift
//  MusicTouchSwiftUI
//
//  Created by Pedro L. Diaz Montilla on 18/8/21.
//

import SwiftUI

struct SongList: View {
	
	var songsFilter: SongFilter
	var controller: MusicTouchController
	
	enum SongFilter {
		case byPlaylist (String)
		case byAlbum (MTAlbumData)
		case byArtist (MTArtistData)
		case all
	}

    var body: some View {
		
		switch songsFilter {
			case let .byPlaylist (name):
				SongListByPlaylist(name: name, controller: controller)
			case let .byAlbum (albumData):
				SongListWithAlbums(albums: [albumData], controller: controller)
			case .all:
				let albums = self.controller.songController.getAlbums()
				SongListWithAlbums(albums: albums, controller: controller)
			default:
				Text("")
		}
		
    }
}

struct SongListByPlaylist: View {
	
	var name: String
	var controller: MusicTouchController
	
	private var albumsList: [MTAlbumData] 	{ self.controller.songController.getAlbums(byPlaylistName: name) }
	private var songsList: [MTSongData] 	{ self.controller.songController.getSongs(byPlaylistName: name) }
	
	var body: some View {
		List {
			ForEach(albumsList) { album in
				
				let songsInAlbum 			= self.controller.songController.getSongs(byPlaylistName: name, byAlbum: album)
				let songsInAlbumDuration 	= self.controller.songController.songsDuration(songs: songsInAlbum)
				
				Section(header: SongAlbumRow(album: album, duration: songsInAlbumDuration)) {
					ForEach(songsInAlbum) { song in
						NavigationLink(destination: PlayView(controller: controller).onAppear {
							DispatchQueue.main.async {
								controller.playController.startToPlay(songList: songsList, songToPlay: song)
							}
						})
						{
							SongRow(song: song)
						}
					}
				}
				.textCase(nil)
			}
		}
		.navigationTitle("Songs")
	}
}

struct SongListWithAlbums: View {
	
	var albums: [MTAlbumData]
	var controller: MusicTouchController
	
	var body: some View {

		List() {
			ForEach(albums) { album in
				Section(header: SongAlbumRow(album: album, duration: album.durationText())) {
					ForEach(album.songs) { song in
						NavigationLink(destination: PlayView(controller: controller).onAppear {
							DispatchQueue.main.async {
								controller.playController.startToPlay(songList: album.songs, songToPlay: song)
							}
						})
						{
							SongRow(song: song)
						}
					}
				}
				.textCase(nil)
			}
		}
		.navigationTitle("Songs")
	}
	
}



struct SongList_Previews: PreviewProvider {
    static var previews: some View {
		SongList(songsFilter: .all, controller: MusicTouchController())
    }
}
