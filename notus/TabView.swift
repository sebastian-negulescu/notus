//
//  TabView.swift
//  notus
//
//  Created by Sebastian Negulescu on 2026-03-12.
//

import SwiftUI
import PencilKit

struct TabView<Content: View>: View {
    let y_offset: CGFloat
    @State var x_offset: CGFloat = 0
    @State var intermediate_offset: CGFloat = 0
    
    let line_width: CGFloat = 10
    let radius: CGFloat = 10
    
    let body_dimensions: (CGFloat, CGFloat) = (500, 500)
    let tab_dimensions: (CGFloat, CGFloat) = (50, 50)
    
    let displacement_threshold: CGFloat = 150
    let right_position: CGFloat
    let left_position: CGFloat
    
    let colour: Color
    let content: Content
    
    init(tab_offset: UInt, colour: Color, content: Content) {
        self.y_offset = (tab_dimensions.1 + 2 * line_width) * CGFloat(tab_offset)
        self.colour = colour
        self.content = content
        
        self.right_position = 0
        self.left_position = -body_dimensions.0
    }
    
    var body: some View {
        HStack (alignment: .top, spacing: 0) {
            UnevenRoundedRectangle(topLeadingRadius: radius, bottomLeadingRadius: radius)
                .stroke(colour, lineWidth: line_width)
                .fill(colour)
                .frame(width: tab_dimensions.0, height: tab_dimensions.1)
                
            UnevenRoundedRectangle(bottomLeadingRadius: radius)
                .stroke(colour, lineWidth: line_width)
                .fill(.white)
                .frame(width: body_dimensions.0, height: body_dimensions.1)
                .overlay {
                    content
                }
        }
        .offset(x: (body_dimensions.0 + (intermediate_offset + x_offset))
            .clamped(to: CGFloat(0)...CGFloat(body_dimensions.0)),
                y: y_offset)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    intermediate_offset = gesture.translation.width
                }
                .onEnded { gesture in
                    withAnimation(.spring(duration: 0.2, bounce: 0.1)) {
                        let displacement = abs(
                            gesture.predictedEndLocation.x - gesture.startLocation.x)
                        let is_swiping_right = gesture.predictedEndLocation.x > gesture.startLocation.x
                        if (displacement > displacement_threshold) {
                            if (almost_equal(x_offset, right_position) && !is_swiping_right) {
                                x_offset = left_position
                            } else if (almost_equal(x_offset, left_position) && is_swiping_right) {
                                x_offset = right_position
                            }
                        }
                        intermediate_offset = 0
                    }
                }
        )
    }
}

#Preview {
    TabView(tab_offset: 0, colour: .green, content: Text("hello, world!"))
}
