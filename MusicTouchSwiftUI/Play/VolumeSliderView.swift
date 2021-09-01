//
//  VolumeSliderView.swift
//  MusicTouchSwiftUI
//
//  Created by Pedro L. Diaz Montilla on 25/8/21.
//

import SwiftUI
import UIKit
import MediaPlayer

struct VolumeSliderView: View {

	var maxHeight: CGFloat = 0

	@Binding var volumeValue: Float
	
    var body: some View {
		Rectangle()
			.fill(Color.red)
			.opacity(self.calulateOpacity(volume: volumeValue, maxOpacity: 0.8))
			.frame(height: self.calulateHeight(volume: volumeValue, maxHeight: maxHeight), alignment: .bottom)
			.overlay( VolumeTextView(volumeValue: self.volumeValue) )
	}
	
	private func calulateHeight(volume: Float, maxHeight: CGFloat) -> CGFloat {
		let vol: Float = max(volume, 0.05)
		
		return maxHeight * CGFloat(vol)
	}

	private func calulateOpacity(volume: Float, maxOpacity: Double) -> Double {
		let vol: Float = max(volume, 0.3)
		
		return maxOpacity * Double(vol)
	}

	
}

struct VolumeTextView: View {
	
	var volumeValue: Float
	
	private let maxSize: CGFloat = 45
	private let minSize: CGFloat = 25
	
	var body: some View {
		
		VStack {
			Text("\(Int(volumeValue * 100)) %")
				.foregroundColor(.white)
				.bold()
				.font(.system(size: calculateFontSize(volumeValue: volumeValue)))
				.shadow(color: Color.gray, radius: 5)
				.padding(7)

			Spacer()
		}
	}
	
	private func calculateFontSize(volumeValue: Float) -> CGFloat {
		return minSize + ((maxSize - minSize) * CGFloat(volumeValue))
	}
}

//struct VolumeSliderView_Previews: PreviewProvider {
//    static var previews: some View {
//		VolumeSliderView(height: Binding<CGFloat>(CGFloat(300)))
//    }
//}
