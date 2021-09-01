//
//  SongSimpleRow.swift
//  MusicTouchSwiftUI
//
//  Created by Pedro L. Diaz Montilla on 26/8/21.
//

import SwiftUI

struct SongRow: View {
	
	var song: MTSongData
	
	var body: some View {
		HStack {
			Text("\(song.title())")
				.padding()
			Spacer()
			Text("\(song.durationText())")
				.font(.system(size: 12))
				.foregroundColor(.gray)
		}
		.contentShape(Rectangle())
		.frame(height: ROW_HEIGHT)
	}}

//struct SongSimpleRow_Previews: PreviewProvider {
//    static var previews: some View {
//        SongSimpleRow()
//    }
//}
