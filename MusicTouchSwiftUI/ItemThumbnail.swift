//
//  ItemThumbnail.swift
//  MusicTouchSwiftUI
//
//  Created by Pedro L. Diaz Montilla on 13/8/21.
//

import SwiftUI
import UIKit

struct ItemThumbnail: View {
	var image: UIImage?
	var size: CGFloat
	
	private var img: Image {
		if let _ = image {
			return Image(uiImage: image!)
		}
		else {
			return Image(systemName: "xmark.octagon")
		}
	}
	
    var body: some View {
		img
			.resizable()
			.frame(width: self.size, height: self.size)
			.background(Color.gray)
			.clipShape(Rectangle())
			.cornerRadius(10)
    }
}

struct ItemThumbnail_Previews: PreviewProvider {
    static var previews: some View {
		ItemThumbnail(image: UIImage(named: "")!, size: 100)
    }
}
