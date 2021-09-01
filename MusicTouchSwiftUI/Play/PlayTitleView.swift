//
//  PlayTitleView.swift
//  MusicTouchSwiftUI
//
//  Created by Pedro L. Diaz Montilla on 16/8/21.
//

import SwiftUI

struct PlayTitleView: View {
	var playController: PlayController
	@Binding var artistOffset: CGFloat
	@Binding var albumOffset: CGFloat
	@Binding var songOffset: CGFloat
	@Binding var textColor: Color
	
	private let songChanged = NotificationCenter.default.publisher(for: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange)
	
	@State private var artist: String = "ARTIST"
	@State private var albumTitle: String = "ALBUM"
	@State private var songTitle: String = "SONG"
	
    var body: some View {
		VStack {
			Text(self.artist)
				.foregroundColor(self.textColor)
				.bold()
				.lineLimit(1)
				.font(.title)
				.padding(7)
				.offset(x: artistOffset, y: 0)
			Text(self.albumTitle)
				.foregroundColor(self.textColor)
				.bold()
				.lineLimit(1)
				.font(.title2)
				.padding(7)
				.offset(x: albumOffset, y: 0)
			Text(self.songTitle)
				.foregroundColor(self.textColor)
				.bold()
				.lineLimit(1)
				.font(.title3)
				.padding(7)
				.offset(x: songOffset, y: 0)
		}
		.onReceive(songChanged) { _ in
			
			self.artist		= playController.nowPlayingArtist() ?? "ARTIST"
			self.albumTitle	= playController.nowPlayingAlbumTitle() ?? "ALBUM"
			self.songTitle	= playController.nowPlayingTitle() ?? "TEMA"
		}
    }
}

//struct PlayTitleView_Previews: PreviewProvider {
//    static var previews: some View {
//		PlayTitleView(playController: PlayController(player: PDMPlayer()), offset: CGFloat.zero)
//    }
//}
