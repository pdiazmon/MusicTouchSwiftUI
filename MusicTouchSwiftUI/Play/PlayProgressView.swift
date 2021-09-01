//
//  PlayProgress.swift
//  MusicTouchSwiftUI
//
//  Created by Pedro L. Diaz Montilla on 16/8/21.
//

import SwiftUI

struct PlayProgressView: View {
	
	var playController: PlayController
	@Binding var progressColor: Color
	
	@State private var songProgress = 0.0
	
	private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
	
	private var progressMinutes: Int {
		let currentPlaybackTime = playController.nowPlayingPlaybackTime()
		return Int(currentPlaybackTime / 60)
	}
	private var progressSeconds: Int {
		let currentPlaybackTime = playController.nowPlayingPlaybackTime()
		return Int(currentPlaybackTime.truncatingRemainder(dividingBy: 60))
	}
	private var remainingMinutes: Int {
		let currentPlaybackTime = playController.nowPlayingPlaybackTime()
		return Int((playController.nowPlayingDuration() - currentPlaybackTime) / 60)
	}
	private var remainingSeconds: Int {
		let currentPlaybackTime = playController.nowPlayingPlaybackTime()
		return Int((playController.nowPlayingDuration() - currentPlaybackTime).truncatingRemainder(dividingBy: 60))
	}
	private var progress: String {
		return String(format: "%0i:%02i", progressMinutes, progressSeconds)
	}
	private var remaining: String {
		return String(format: "-%0i:%02i", remainingMinutes, remainingSeconds)
	}
	
    var body: some View {
		VStack {
		
			ProgressView(value: songProgress, total: playController.nowPlayingDuration())
				.foregroundColor(.white)
				.progressViewStyle(LinearProgressViewStyle(tint: self.progressColor))
				.scaleEffect(CGSize(width: 1, height: 2.5))
				.onReceive(timer) { _ in
					if (songProgress < playController.nowPlayingDuration()) {
						songProgress = playController.nowPlayingPlaybackTime()
					}
				}

			HStack {
				Text(progress)
					.foregroundColor(self.progressColor)
				Spacer()
				Text(remaining)
					.foregroundColor(self.progressColor)
			}
			.padding()
		}

	}
}

//struct PlayProgress_Previews: PreviewProvider {
//
//	@State var color: Color = Color.blue
//
//    static var previews: some View {
//		PlayProgressView(playController: PlayController(player: PDMPlayer()), progressColor: color)
//    }
//}
