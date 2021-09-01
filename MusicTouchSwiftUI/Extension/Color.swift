//
//  Color.swift
//  MusicTouchSwiftUI
//
//  Created by Pedro L. Diaz Montilla on 31/8/21.
//

import Foundation
import UIKit
import SwiftUI


extension Color {

	var brightness: CGFloat {
		var r: CGFloat = 0.0
		var g: CGFloat = 0.0
		var b: CGFloat = 0.0
		var a: CGFloat = 0.0
		
		UIColor(self).getRed(&r, green: &g, blue: &b, alpha: &a)
		
		// algorithm from: http://www.w3.org/WAI/ER/WD-AERT/#color-contrast
		return ((r * 299) + (g * 587) + (b * 114)) / 1000;
	}
	
	var isTooLight: Bool { self.brightness > 0.65 }
	
	var isTooDark: Bool { self.brightness < 0.3 }
	
	var inverseColor: Color {
		var alpha: CGFloat = 1.0

		var red: CGFloat = 0.0
		var green: CGFloat = 0.0
		var blue: CGFloat = 0.0
		
		if UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
			return Color(red: 1.0 - Double(red), green: 1.0 - Double(green), blue: 1.0 - Double(blue), opacity: Double(alpha))
		}

		var hue: CGFloat = 0.0
		var saturation: CGFloat = 0.0
		var brightness: CGFloat = 0.0
		if UIColor(self).getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
			return Color(hue: 1.0 - Double(hue), saturation: 1.0 - Double(saturation), brightness: 1.0 - Double(brightness), opacity: Double(alpha))
		}

		var white: CGFloat = 0.0
		if UIColor(self).getWhite(&white, alpha: &alpha) {
			return Color(white: 1.0 - Double(white), opacity: Double(alpha))
		}

		return self
	}

}
