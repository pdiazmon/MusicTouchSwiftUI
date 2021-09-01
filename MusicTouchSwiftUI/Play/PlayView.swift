//
//  PlayView.swift
//  MusicTouchSwiftUI
//
//  Created by Pedro L. Diaz Montilla on 22/8/21.
//

import SwiftUI
import MediaPlayer

struct VolumeGestureHandler {
	var initY: Float = 0.0
	var initValue: Float = 0.0
}

struct PlayView: View {
	
	enum SwipeDirection {
		case horizontal
		case vertical
		case none
	}
	
	var controller: MusicTouchController
	
	@State private var artworkImage = UIImage(systemName: "music.note")!
	@State private var artworkImageColor: Color = Color.blue
	@State private var artworkImageScale: CGFloat = 1
	@State private var artworkImageShadow: Bool = true
	
	private let artworkThumbnailSize: CGFloat = 300
	@State private var artworkOffset: CGFloat = CGFloat.zero
	@State private var swipeHorizontalInProgress: Bool = false
	@State private var swipeVerticalInProgress: Bool = false
	@State private var startx: CGFloat = CGFloat.zero
	
	@State private var artistOffset: CGFloat = CGFloat.zero
	@State private var albumOffset: CGFloat = CGFloat.zero
	@State private var songOffset: CGFloat = CGFloat.zero
	
	@State private var isEqualizarAnimating: Bool = true
	
	@State private var isVolumeChanging: Bool = false
	
	private let SWIPE_TRHESHOLD: CGFloat = 60
	@State private var swipeDirection: SwipeDirection = .none
	
	@State private var volumeHandler = VolumeGestureHandler()
	
	@State private var volumeSlider = MPVolumeView().subviews.filter{NSStringFromClass($0.classForCoder) == "MPVolumeSlider"}.first as? UISlider
	@State private var initVolumeLevel: Float = 0
	@State private var newVolumeLevel: Float = 0
	
	private let songChanged = NotificationCenter.default.publisher(for: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange)
	private let volumeChanged = NotificationCenter.default.publisher(for: NSNotification.Name.MPMusicPlayerControllerVolumeDidChange)
	
	var body: some View {

		GeometryReader { geometry in

			ZStack {
				MPVolumeViewSwiftUI()
					.frame(width: 0, height: 0)
				
				Image(uiImage: artworkImage)
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(width: geometry.size.width, height: geometry.size.height)
					.blur(radius: 40)
				
				VStack {
						ArtworkThumbnailView(artworkImage: $artworkImage,
											 size: artworkThumbnailSize,
											 offset: $artworkOffset,
											 scale: $artworkImageScale,
											 shadow: $artworkImageShadow)
							.overlay(
								EqualiserView(color: self.$artworkImageColor)
									.hidden(!isEqualizarAnimating)
							)
					
					Spacer()
						
					PlayProgressView(playController: controller.playController, progressColor: self.$artworkImageColor)
						.padding()

					Spacer()
					
					PlayTitleView(playController: controller.playController,
								  artistOffset: self.$artistOffset,
								  albumOffset: self.$albumOffset,
								  songOffset: self.$songOffset,
								  textColor: self.$artworkImageColor)
					
					Spacer()
				}
				
				VStack {
					Spacer()
					
					VolumeSliderView(maxHeight: geometry.size.height, volumeValue: self.$newVolumeLevel)
						.hidden(!self.isVolumeChanging)
						.frame(alignment: .bottom)
				}
				
			}
			.onAppear {
				artworkOffset = 0
				UIApplication.shared.isIdleTimerDisabled = true
			}
			.onDisappear { UIApplication.shared.isIdleTimerDisabled = false }
			.gesture(DragGesture()
				.onChanged { value in self.handleSwipeOnChanged(value: value, geometry: geometry) }
				.onEnded   { value in self.handleSwipeOnEnded(value: value, geometry: geometry) }
			)
			.onTapGesture { handleTap() }
			.onReceive(songChanged) { _ in handleSongChanged() }
			.onReceive(volumeChanged) { _ in handleVolumeChanged() }
		}
	}
}

extension PlayView {
	
	func handleTap() {
		self.controller.playController.togglePlayPause()
		self.isEqualizarAnimating = controller.playController.isPlaying()
	}
	
	func handleSongChanged() {
		if let song = controller.playController.getPlayer().nowPlayingItem() {
			if let img = song.artwork {
				self.artworkImage = (img.image(at: CGSize.zero) ?? UIImage(systemName: "music.note")!)
				self.artworkImageColor = Color(self.artworkImage.averageColor ?? UIColor.blue)
				
				if (self.artworkImageColor.isTooLight || self.artworkImageColor.isTooDark) {
					self.artworkImageColor = self.artworkImageColor.inverseColor
				}
				
			}
		}
	}
	
	func handleSwipeOnChanged(value: DragGesture.Value, geometry: GeometryProxy) {
		
		// Movement delta
		let deltaY = abs(value.location.y - value.startLocation.y)
		let deltaX = abs(value.location.x - value.startLocation.x)
		
		// Already moving ?
		if (self.swipeDirection == .none) {
			
			// If moving horizontally
			if (deltaX >= SWIPE_TRHESHOLD) {
				self.swipeDirection = .horizontal
			}
			// If moving horizontally
			else if(deltaY >= SWIPE_TRHESHOLD) {
				self.swipeDirection = .vertical
			}
		}
		
		switch self.swipeDirection {
			case .horizontal: handleSwipeOnChangedHorizontal(value: value, geometry: geometry)
			case .vertical: handleSwipeOnChangedVertical(value: value, geometry: geometry)
			case .none: break
		}
	}
		
	func handleSwipeOnChangedHorizontal(value: DragGesture.Value, geometry: GeometryProxy) {
		
		// Swipping to right
		if (value.location.x > value.startLocation.x && controller.playController.isPlayingFirst()) {
			return
		}
		// Swipping to left
		else if (value.location.x < value.startLocation.x && controller.playController.isPlayingLast()) {
			return
		}
		
		if (!swipeHorizontalInProgress) {
			swipeHorizontalInProgress = true
			startx = artworkOffset
		}

		artworkOffset = startx + (value.location.x - value.startLocation.x)
		
		self.isEqualizarAnimating = false
	}
	
	func handleSwipeOnChangedVertical(value: DragGesture.Value, geometry: GeometryProxy) {
		
		if(!swipeVerticalInProgress) {
			swipeVerticalInProgress = true
			
			self.volumeHandler.initY     = Float(value.location.y)
			self.volumeHandler.initValue = volumeSlider?.value ?? 0
			initVolumeLevel              = Float(self.volumeHandler.initValue)
			
			isVolumeChanging = true
		}
		
		let incrDeltaY = (self.volumeHandler.initY - Float(value.location.y)) / Float(geometry.size.height)
		newVolumeLevel = max(min(self.volumeHandler.initValue + incrDeltaY, 1), 0)
		
		// If the delta Y movement is less than 0.01 we do not change the volume
		if (abs(initVolumeLevel - newVolumeLevel) >= 0.01 && newVolumeLevel <= 1 && newVolumeLevel >= 0) {
			// Increase/decrease the volume level
			volumeSlider?.setValue(newVolumeLevel, animated: false)
			initVolumeLevel = newVolumeLevel
		}
	}
	
	func handleSwipeOnEnded(value: DragGesture.Value, geometry: GeometryProxy) {
		
		switch self.swipeDirection {
			case .horizontal: handleSwipeOnEndedHorizontal(value: value, geometry: geometry)
			case .vertical: handleSwipeOnEndedVertical(value: value, geometry: geometry)
			case .none: break
		}
		
		self.swipeDirection = .none
	}
		
	func handleSwipeOnEndedHorizontal(value: DragGesture.Value, geometry: GeometryProxy) {
		
		swipeHorizontalInProgress = false

		// Swipping to right
		if (value.location.x > value.startLocation.x && controller.playController.isPlayingFirst()) {
			return
		}
		// Swipping to left
		else if (value.location.x < value.startLocation.x && controller.playController.isPlayingLast()) {
			return
		}
		
		let scroll = abs(value.startLocation.x - value.location.x)

		guard (scroll > 60) else {
			withAnimation {
				artworkOffset = 0
			}
			return
		}
		
		self.isEqualizarAnimating = controller.playController.isPlaying()
		
		// Swipe to right
		if (value.location.x > value.startLocation.x) {

			withAnimation {
				artworkOffset = geometry.size.width
				artistOffset = geometry.size.width
				albumOffset = geometry.size.width
				songOffset = geometry.size.width
			}
			
			artworkOffset = -(geometry.size.width - self.artworkThumbnailSize)/2 - self.artworkThumbnailSize
			artistOffset = -(geometry.size.width)
			albumOffset = -(geometry.size.width)
			songOffset = -(geometry.size.width)
			
			controller.playController.playPrevious()
			
			withAnimation {	artworkOffset = 0 }
			withAnimation(Animation.easeIn(duration: 0.2)) { artistOffset = 0 }
			withAnimation(Animation.easeIn(duration: 0.3)) { albumOffset = 0 }
			withAnimation(Animation.easeIn(duration: 0.4)) { songOffset = 0 }
			
		}
		// Swipe to left
		else if (value.location.x < value.startLocation.x) {

			withAnimation {
				artworkOffset = -geometry.size.width
				artistOffset = -geometry.size.width
				albumOffset = -geometry.size.width
				songOffset = -geometry.size.width
			}
			
			artworkOffset = geometry.size.width
			artistOffset = geometry.size.width
			albumOffset = geometry.size.width
			songOffset = geometry.size.width
			
			controller.playController.playNext()
			
			withAnimation { artworkOffset = 0}
			withAnimation(Animation.easeIn(duration: 0.2)) { artistOffset = 0 }
			withAnimation(Animation.easeIn(duration: 0.3)) { albumOffset = 0 }
			withAnimation(Animation.easeIn(duration: 0.4)) { songOffset = 0 }
		}
	}
	
	private func handleSwipeOnEndedVertical(value: DragGesture.Value, geometry: GeometryProxy) {
		swipeVerticalInProgress = false
		isVolumeChanging = false
	}
	
	private func handleVolumeChanged() {
		
		guard (swipeVerticalInProgress == false) else { return }
		
		if let volumeSlider = self.volumeSlider {
			// Show a the transparent view with the new volume label and hide it after a time
			newVolumeLevel = volumeSlider.value
			isVolumeChanging = true
			
			withAnimation(Animation.easeInOut.delay(0.5)) { isVolumeChanging = false }
		}

	}
}


//struct PlayView_Previews: PreviewProvider {
//
//	static var previews: some View {
//		PlayView(controller: MusicTouchController())
//	}
//}
