//
//  EqualiserView.swift
//  MusicTouchSwiftUI
//
//  Created by Pedro L. Diaz Montilla on 24/8/21.
//

import SwiftUI
import Combine

struct EqualiserView: View {
	
	var numBars = 5

	@State private var animating = false
	@Binding var color: Color
	
	@State var timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
	
	var body: some View {
		GeometryReader { (geometry: GeometryProxy) in

			HStack(alignment: .bottom, spacing: 0) {
				ForEach(0..<numBars) { index in
					EqualiserBar(id: index, maxHeight: geometry.size.height, color: $color, animating: animating ? 1 : 0, timer: $timer)
						.frame(height: geometry.size.height, alignment: .bottom)
						
				}
			}
			.frame(height: geometry.size.height)
			.onAppear { animating = true }
		}
	}
}

private struct EqualiserBar: View {
	
	var id: Int
	var maxHeight: CGFloat
	@Binding var color: Color
	var animating: Int
	@Binding var timer: Publishers.Autoconnect<Timer.TimerPublisher>
	
	@State private var barHeight: CGFloat = 1
	
	var body: some View {
		ZStack {
			Rectangle()
				.fill(self.color)
				.opacity(0.3)
				.frame(height: barHeight)
				.animation(.easeInOut(duration: 0.8 + Double.random(in: -0.3...0.3))
							.delay(Double.random(in: 0...0.2)))
		}
		.onReceive(timer) { _ in
			withAnimation {
				barHeight = CGFloat.random(in: 1...maxHeight)
			}
		}
	}
}

struct EqualiserView_Previews: PreviewProvider {
	static var previews: some View {
			NavigationView {
				GeometryReader { geometry in

					ZStack {
						Image(systemName: "music.note")
							.resizable()
							.aspectRatio(contentMode: .fill)
							.frame(width: geometry.size.width, height: geometry.size.height)
							.blur(radius: 40)

						VStack {
							Image(systemName: "music.note")
								.resizable()
								.frame(width: 300, height: 300)
							Spacer()
							Text("AA")
							Spacer()
							Text("BB")
							Spacer()
						}
					}
				}
			}
			.navigationTitle("TEST")
	}
}
