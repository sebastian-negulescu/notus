//
//  background.swift
//  notus
//
//  Created by Sebastian Negulescu on 2026-05-15.
//

import SwiftUI

enum Pattern: Int {
    case Blank = 0
    case Line
    case Grid
    case Dot
    case Iso
}

struct BackgroundInfo {
    let spacing: CGFloat
    let weight: CGFloat
    let background_colour: Color
    let pattern_colour: Color
    let pattern: Pattern
}

func fill_background(_ context: inout GraphicsContext, _ size: CGSize, info: BackgroundInfo) -> Void {
    context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(info.background_colour))
    let pattern_path = generate_pattern(pattern: info.pattern, size: size, spacing: info.spacing)
    context.stroke(pattern_path, with: .color(info.pattern_colour), lineWidth: info.weight)
}

func generate_pattern(pattern: Pattern, size: CGSize, spacing: CGFloat) -> Path {
    var path = Path()
    let midpoint = CGSize(width: size.width / 2, height: size.height / 2)
    let filler_weight = 1.0
    
    switch (pattern) {
    case .Line:
        for y in stride(from: midpoint.height + spacing / 2, through: size.height, by: spacing) {
            path.move(to: CGPoint(x: 0, y: y))
            path.addLine(to: CGPoint(x: size.width, y: y))
        }
        for y in stride(from: midpoint.height - spacing / 2, through: 0, by: -spacing) {
            path.move(to: CGPoint(x: 0, y: y))
            path.addLine(to: CGPoint(x: size.width, y: y))
        }
    case .Grid:
        for x in stride(from: midpoint.width + spacing / 2, through: size.width, by: spacing) {
            path.move(to: CGPoint(x: x, y: 0))
            path.addLine(to: CGPoint(x: x, y: size.height))
        }
        for x in stride(from: midpoint.width - spacing / 2, through: 0, by: -spacing) {
            path.move(to: CGPoint(x: x, y: 0))
            path.addLine(to: CGPoint(x: x, y: size.height))
        }
        for y in stride(from: midpoint.height + spacing / 2, through: size.height, by: spacing) {
            path.move(to: CGPoint(x: 0, y: y))
            path.addLine(to: CGPoint(x: size.width, y: y))
        }
        for y in stride(from: midpoint.height - spacing / 2, through: 0, by: -spacing) {
            path.move(to: CGPoint(x: 0, y: y))
            path.addLine(to: CGPoint(x: size.width, y: y))
        }
    case .Dot:
        for x in stride(from: midpoint.width + spacing / 2, through: size.width, by: spacing) {
            for y in stride(from: midpoint.height + spacing / 2, through: size.height, by: spacing) {
                let rect = CGRect(x: x - (filler_weight / 2),
                                  y: y - (filler_weight / 2),
                                  width: filler_weight,
                                  height: filler_weight)
                path.addEllipse(in: rect)
            }
            for y in stride(from: midpoint.height - spacing / 2, through: 0, by: -spacing) {
                let rect = CGRect(x: x - (filler_weight / 2),
                                  y: y - (filler_weight / 2),
                                  width: filler_weight,
                                  height: filler_weight)
                path.addEllipse(in: rect)
            }
        }
        for x in stride(from: midpoint.width - spacing / 2, through: 0, by: -spacing) {
            for y in stride(from: midpoint.height + spacing / 2, through: size.height, by: spacing) {
                let rect = CGRect(x: x - (filler_weight / 2),
                                  y: y - (filler_weight / 2),
                                  width: filler_weight,
                                  height: filler_weight)
                path.addEllipse(in: rect)
            }
            for y in stride(from: midpoint.height - spacing / 2, through: 0, by: -spacing) {
                let rect = CGRect(x: x - (filler_weight / 2),
                                  y: y - (filler_weight / 2),
                                  width: filler_weight,
                                  height: filler_weight)
                path.addEllipse(in: rect)
            }
        }
    case .Iso:
        let line_height = sqrt((spacing * spacing - spacing * spacing / 4))
        var offset: Bool = true
        for x in stride(from: midpoint.width + spacing / 2, through: size.width + spacing, by: spacing) {
            offset = true
            for y in stride(from: midpoint.height + line_height / 2, through: size.height, by: line_height) {
                var x_mod = x
                if offset {
                    x_mod -= spacing / 2
                }
                let rect = CGRect(x: x_mod - (filler_weight / 2),
                                  y: y - (filler_weight / 2),
                                  width: filler_weight,
                                  height: filler_weight)
                path.addEllipse(in: rect)
                offset = !offset
            }
            offset = false
            for y in stride(from: midpoint.height - line_height / 2, through: 0, by: -line_height) {
                var x_mod = x
                if offset {
                    x_mod -= spacing / 2
                }
                let rect = CGRect(x: x_mod - (filler_weight / 2),
                                  y: y - (filler_weight / 2),
                                  width: filler_weight,
                                  height: filler_weight)
                path.addEllipse(in: rect)
                offset = !offset
            }
        }
        for x in stride(from: midpoint.width - spacing / 2, through: 0, by: -spacing) {
            offset = true
            for y in stride(from: midpoint.height + line_height / 2, through: size.height, by: line_height) {
                var x_mod = x
                if offset {
                    x_mod -= spacing / 2
                }
                let rect = CGRect(x: x_mod - (filler_weight / 2),
                                  y: y - (filler_weight / 2),
                                  width: filler_weight,
                                  height: filler_weight)
                path.addEllipse(in: rect)
                offset = !offset
            }
            offset = false
            for y in stride(from: midpoint.height - line_height / 2, through: 0, by: -line_height) {
                var x_mod = x
                if offset {
                    x_mod -= spacing / 2
                }
                let rect = CGRect(x: x_mod - (filler_weight / 2),
                                  y: y - (filler_weight / 2),
                                  width: filler_weight,
                                  height: filler_weight)
                path.addEllipse(in: rect)
                offset = !offset
            }
        }
    default:
        break
    }
    
    return path
}
