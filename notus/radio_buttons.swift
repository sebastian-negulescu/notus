//
//  radio_buttons.swift
//  notus
//
//  Created by Sebastian Negulescu on 2026-05-13.
//

import SwiftUI

struct RadioButtonInfo {
    let icon_names: [String]
    let dimensions: CGSize
    let padding: CGFloat
    let selected_colour: Color
    let selected_weight: CGFloat
}

struct RadioButtons: View {
    let info: RadioButtonInfo
    @Binding var selected: Int
    
    var body: some View {
        HStack {
            ForEach(Array(info.icon_names.enumerated()), id: \.offset) { index, name in
                Image(systemName: name)
                    .resizable()
                    .scaledToFit()
                    .frame(width: info.dimensions.width, height: info.dimensions.height)
                    .padding(info.padding)
                    .overlay(
                        Circle()
                            .stroke(selected == index ? info.selected_colour : .clear, lineWidth: info.selected_weight)
                    )
                    .onTapGesture {
                        selected = index
                    }
            }
        }
    }
}

#Preview {
    @Previewable @State var selected = 0
    let info = RadioButtonInfo(icon_names: ["circle", "square", "triangle"], dimensions: CGSize(width: 40, height: 40), padding: 10, selected_colour: .purple, selected_weight: 5)
    RadioButtons(info: info, selected: $selected)
}
