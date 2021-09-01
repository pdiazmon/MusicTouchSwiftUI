//
//  AlbumRow.swift
//  MusicTouchSwiftUI
//
//  Created by Pedro L. Diaz Montilla on 13/8/21.
//

import SwiftUI

struct AlbumRow: View {
	
	var album: MTAlbumData
	
	var body: some View {
		HStack {
			ItemThumbnail(image: album.image(), size: ROW_HEIGHT * 0.9)
			Text(album.albumTitle)
			Spacer()
			Text("\(album.numberOfSongs) songs")
		}
		.frame(height: ROW_HEIGHT)
	}

}

//struct AlbumRow_Previews: PreviewProvider {
//    static var previews: some View {
//        AlbumRow()
//    }
//}
