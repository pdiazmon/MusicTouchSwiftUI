//
//  ArtistRow.swift
//  MusicTouchSwiftUI
//
//  Created by Pedro L. Diaz Montilla on 13/8/21.
//

import SwiftUI

struct ArtistRow: View {
	
	var artist: MTArtistData
	
	var body: some View {
		HStack {
			ItemThumbnail(image: artist.image(), size: ROW_HEIGHT * 0.90)
			Text(artist.title())
			Spacer()
			Text("\(artist.numberOfAlbums) albums")
		}
		.frame(height: ROW_HEIGHT)
	}
}

//struct ArtistRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ArtistRow()
//    }
//}
