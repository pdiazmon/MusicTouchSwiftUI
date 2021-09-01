//
//  SongAlbumRow.swift
//  MusicTouchSwiftUI
//
//  Created by Pedro L. Diaz Montilla on 26/8/21.
//

import SwiftUI

struct SongAlbumRow: View {
	
	var album: MTAlbumData
	var duration: String
	
	var body: some View {
		HStack {
			ItemThumbnail(image: album.image(), size: ROW_HEIGHT * 0.90)
			VStack(alignment: .leading, spacing: 3) {
				Spacer()
				Text("\(album.artistName)")
				Text("\(album.albumTitle)")
				Spacer()
			}
			Spacer()
			Text("\(duration)")
				.font(.system(size: 15))
		}
		.contentShape(Rectangle())
		.frame(height: ROW_HEIGHT)
	}
}

//struct SongAlbumRow_Previews: PreviewProvider {
//    static var previews: some View {
//        SongAlbumRow()
//    }
//}
