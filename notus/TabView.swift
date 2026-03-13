//
//  TabView.swift
//  notus
//
//  Created by Sebastian Negulescu on 2026-03-12.
//

import SwiftUI
import PencilKit

struct TabView<Content: View>: View {
    let colour: Color
    let content: Content
    
    init(colour: Color, content: Content) {
        self.colour = colour
        self.content = content
    }
    
    let line_width: CGFloat = 4
    let radius: CGFloat = 10
    
    var body: some View {
        HStack (alignment: .top, spacing: 0) {
            UnevenRoundedRectangle(topLeadingRadius: radius, bottomLeadingRadius: radius)
                .stroke(colour, lineWidth: 4)
                .fill(colour)
                .frame(width: 50, height: 50)
            UnevenRoundedRectangle(bottomLeadingRadius: radius)
                .stroke(colour, lineWidth: 4)
                .frame(width: 500, height: 500)
                .overlay {
                    content
                }
        }
    }
}

#Preview {
    TabView(colour: .green, content: Text("hello, world!"))
}
