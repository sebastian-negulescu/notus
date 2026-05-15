//
//  miscellaneous.swift
//  notus
//
//  Created by Sebastian Negulescu on 2026-03-14.
//

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}

func almost_equal<T:FloatingPoint>(_ a:T, _ b:T) -> Bool {
    return b.nextDown ... b.nextUp ~= a
}

let do_nothing: () -> Void = {}
