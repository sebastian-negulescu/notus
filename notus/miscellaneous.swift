//
//  miscellaneous.swift
//  notus
//
//  Created by Sebastian Negulescu on 2026-03-14.
//

import SwiftUI

extension Color {
    var suggestedTextColour: Color {
        // 1. Extract components via cgColor
        guard let components = self.cgColor?.components, components.count >= 3 else {
            return .black // Safe fallback
        }
        
        // 2. Convert the 0.0-1.0 Swift values to the standard 0-255 scale
        let r = components[0] * 255
        let g = components[1] * 255
        let b = components[2] * 255
        
        // 3. Calculate perceived luminance
        let luminance = (r * 0.299) + (g * 0.587) + (b * 0.114)
        
        // 4. Apply the W3C threshold
        return luminance > 186 ? .black : .white
    }
}

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}

func almost_equal<T:FloatingPoint>(_ a:T, _ b:T) -> Bool {
    return b.nextDown ... b.nextUp ~= a
}

let do_nothing: () -> Void = {}
