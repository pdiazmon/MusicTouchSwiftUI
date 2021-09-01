//
//  View.swift
//  MusicTouchSwiftUI
//
//  Created by Pedro L. Diaz Montilla on 22/8/21.
//

import Foundation
import SwiftUI

extension View {
  @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
	switch shouldHide {
	  case true: self.hidden()
	  case false: self
	}
  }
}
