//
//  paper_tab_view.swift
//  notus
//
//  Created by Sebastian Negulescu on 2026-05-15.
//

import SwiftUI

struct PaperTabView: View {
    let tab_offset: UInt
    @Binding var background: BackgroundInfo
    @State var preview_background: BackgroundInfo
    
    init(tab_offset: UInt, background: Binding<BackgroundInfo>) {
        self.tab_offset = tab_offset
        self._background = background
        self.preview_background = background.wrappedValue
    }

    let pattern_info = RadioButtonInfo(
        icon_names: ["circle", "equal.circle", "square.circle", "circle.grid.3x3.circle", "circle.hexagongrid.circle"],
        icon_colours: [.black, .black, .black, .black, .black],
        dimensions: CGSize(width: 40, height: 40),
        padding: 8,
        selected_colour: .blue,
        selected_weight: 3)
    @State var pattern_selected = 0
    
    let colours_info = RadioButtonInfo(
        icon_names: ["circle", "circle.fill", "circle.fill"],
        icon_colours: [.black, .black, Color(red: 251/255, green: 241/255, blue: 199/255)],
        dimensions: CGSize(width: 40, height: 40),
        padding: 8,
        selected_colour: .blue,
        selected_weight: 3)
    @State var colour_selected = 0
    
    var content: some View {
        VStack {
            HStack {
                Text("Pattern")
                    .font(.title2)
                    .frame(minWidth: 100, alignment: .leading)
                RadioButtons(info: pattern_info, selected: $preview_background.raw_pattern)
                Spacer()
            }
            HStack {
                Text("Spacing")
                    .font(.title2)
                    .frame(minWidth: 100, alignment: .leading)
                Slider(value: $preview_background.spacing, in: 25...75)
                    .frame(maxWidth: 300)
                Spacer()
            }
            HStack {
                Text("Weight")
                    .font(.title2)
                    .frame(minWidth: 100, alignment: .leading)
                Slider(value: $preview_background.weight, in: 0.1...10)
                    .frame(maxWidth: 300)
                Spacer()
            }
            HStack {
                Text("Colour")
                    .font(.title2)
                    .frame(minWidth: 100, alignment: .leading)
                RadioButtons(info: colours_info, selected: $preview_background.raw_colour)
                Spacer()
            }
            Spacer()
            Canvas { context, size in
                fill_background(&context, size,
                                info: preview_background)
            }
                .border(.black)
            Spacer()
            HStack {
                Button(action: {
                    background = preview_background
                }) {
                    Text("Apply current")
                }
                .buttonStyle(.bordered)
                Button(action: {
                    background = preview_background
                }) {
                    Text("Apply all")
                }
                .buttonStyle(.bordered)
                Button(action: {
                    preview_background = background
                }) {
                    Text("Discard")
                    .foregroundStyle(.red)
                }
                .buttonStyle(.bordered)
            }
        }
        .padding(20)
    }
    
    var body: some View {
        TabView(tab_offset: self.tab_offset, colour: .blue, content: content)
    }
}

#Preview {
    @Previewable @State var background = BackgroundInfo(spacing: 1,
                                           weight: 1,
                                           raw_colour: 0,
                                           raw_pattern: 0)
    PaperTabView(tab_offset: 0, background: $background)
        .offset(x: -500)
}
