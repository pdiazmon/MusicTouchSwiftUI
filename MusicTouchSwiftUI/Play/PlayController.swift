//
//  PlayController.swift
//  MusicTouch
//
//  Created by Pedro L. Diaz Montilla on 13/04/2020.
//  Copyright © 2020 Pedro L. Diaz Montilla. All rights reserved.
//

import Foundation
//import UIKit
import MediaPlayer

class PlayController {
	
	private var player: PlayerProtocol

	init(player: PlayerProtocol) {
		self.player = player
	}
		
	/// Gets the player object
	/// - Returns: Player object
	func getPlayer() -> PlayerProtocol {
		return self.player
	}
	
	/// Indicates if the music is playing
	/// - Returns: true if yes, false if not
	func isPlaying() -> Bool {
		return self.player.isPlaying()
	}
	
	/// Indicates if the music is paused
	/// - Returns: true if yes, false if not
	func isPaused() -> Bool {
		return self.player.isPaused()
	}
	
	/// Indicates if the song being played is the last one of the list
	/// - Returns: true if yes, false if not
	func isPlayingLast() -> Bool {
		return self.player.isPlayingLast()
	}
	
	/// Indicates if the song being played is the first one of the list
	/// - Returns: true if yes, false if not
	func isPlayingFirst() -> Bool {
		   return self.player.isPlayingFirst()
	   }
	
	/// Pauses the music
	func pauseSong() {
		return self.player.pauseSong()
	}
	
	/// Gets the name of the artist being played now
	/// - Returns: Name of the artist
	func nowPlayingArtist() -> String? {
		return self.player.nowPlayingArtist()
	}
	
	/// Gets the title of the album for the music being played now
	/// - Returns: Title of the album
	func nowPlayingAlbumTitle() -> String? {
		return self.player.nowPlayingAlbumTitle()
	}
	
	/// Gets the title of the song being played now
	/// - Returns: Title of the song
	func nowPlayingTitle() -> String? {
		return self.player.nowPlayingTitle()
	}
	
	/// Gets the artwork of the song being played now
	/// - Returns: Artwork of the song
	func nowPlayingArtwork() -> MPMediaItemArtwork? {
		return self.player.nowPlayingArtwork()
	}
	
	/// Indicates if the player is on shuffle mode or not
	/// - Returns: true if yes, false if not
	func isShuffleOn() -> Bool {
		return self.player.isShuffleOn()
	}
	
	/// Gets the playback time of the song being played now
	/// - Returns: Song's playback time
	func nowPlayingPlaybackTime() -> TimeInterval {
		return self.player.nowPlayingPlaybackTime()
	}
	
	/// Gets the time duration of the song being played now
	/// - Returns: Song's duration
	func nowPlayingDuration() -> TimeInterval {
		return self.player.nowPlayingDuration()
	}
	
	/// Tells the player to play the previous song
	func playPrevious() {
		self.player.playPrevious()
	}
	
	/// Tells the player to play the next song
	func playNext() {
		self.player.playNext()
	}
	
	private func setSongList(songList: [MTSongData]) {
		let collection = MPMediaItemCollection(items: songList.compactMap { $0.mediaItem })
		
		self.player.setCollection(collection)
	}
	
	private func setSong(song: MTSongData) {
		self.player.setSong(song.mediaItem)
	}
	
	private func play() {
		self.player.playSong()		
	}
	
	func startToPlay(songList: [MTSongData], songToPlay: MTSongData) {
		self.setSongList(songList: songList)
		self.setSong(song: songToPlay)
		self.play()

	}
	
	func togglePlayPause() {
		if (self.player.isPlaying()) {
			self.pauseSong()
		}
		else {
			self.play()
		}
	}
	
	func nextSongImage() -> UIImage {
		
		guard let nextSong = self.player.getNextSong() else { return UIImage(systemName: "music.note")! }
		guard let nextSongArtwork = nextSong.artwork else { return UIImage(systemName: "music.note")! }
		guard let nextSongArtworkImage = nextSongArtwork.image(at: CGSize.zero) else { return UIImage(systemName: "music.note")! }
		
		return nextSongArtworkImage
	}

	func previousSongImage() -> UIImage {
		
		guard let previousSong = self.player.getNextSong() else { return UIImage(systemName: "music.note")! }
		guard let previousSongArtwork = previousSong.artwork else { return UIImage(systemName: "music.note")! }
		guard let previousSongArtworkImage = previousSongArtwork.image(at: CGSize.zero) else { return UIImage(systemName: "music.note")! }
		
		return previousSongArtworkImage
	}

}
