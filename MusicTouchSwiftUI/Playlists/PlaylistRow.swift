//
//  PlaylistRow.swift
//  MusicTouchSwiftUI
//
//  Created by Pedro L. Diaz Montilla on 12/8/21.
//

import SwiftUI

struct PlaylistRow: View {
	
	var playlist: MTPlaylistData
	
	private let ROW_HEIGHT: CGFloat = 75
	
	var body: some View {
		HStack {
			ItemThumbnail(image: playlist.image(), size: ROW_HEIGHT * 0.90)
			Text(playlist.name)
			Spacer()
			Text("\(playlist.numberOfSongs) songs")
		}
		.frame(height: ROW_HEIGHT)
	}
}

struct PlaylistRow_Previews: PreviewProvider {
    static var previews: some View {
		PlaylistRow(playlist: MTPlaylistData(persistentID: nil, name: "Playlist", mediaLibrary: PDMMediaLibrary()))
    }
}
