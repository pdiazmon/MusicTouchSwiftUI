//
//  File.swift
//  MusicTouchSwiftUI
//
//  Created by Pedro L. Diaz Montilla on 30/8/21.
//

import Foundation
import SwiftUI
import MediaPlayer


class MPVolumeViewController: UIViewController {

	var mpvolumeview: MPVolumeView = MPVolumeView(frame: .zero)

	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(mpvolumeview)
	}
}

struct MPVolumeViewSwiftUI: UIViewControllerRepresentable {

	func makeUIViewController(context: UIViewControllerRepresentableContext<MPVolumeViewSwiftUI>) -> MPVolumeViewController {
		return MPVolumeViewController()
	}

	func updateUIViewController(_ uiViewController: MPVolumeViewController, context: UIViewControllerRepresentableContext<MPVolumeViewSwiftUI>) {
		// Nothing to do
	}
	
	
}
