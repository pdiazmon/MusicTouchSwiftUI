//
//  ArtworkThumbnailView.swift
//  MusicTouchSwiftUI
//
//  Created by Pedro L. Diaz Montilla on 22/8/21.
//

import SwiftUI

struct ArtworkThumbnailView: View {
	
	@Binding var artworkImage: UIImage
	var size: CGFloat
	@Binding var offset: CGFloat
	@Binding var scale: CGFloat
	@Binding var shadow: Bool
	
    var body: some View {
		Image(uiImage: artworkImage)
			.resizable()
			.frame(width: size, height: size)
			.cornerRadius(10)
			.shadow(color: Color.black.opacity( self.shadow ? 1 : 0 ), radius: 20, x: 0, y: 10)
			.scaleEffect(scale)
			.offset(x: offset, y: 0)
    }
}

//struct ArtworkThumbnailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArtworkThumbnailView()
//    }
//}
