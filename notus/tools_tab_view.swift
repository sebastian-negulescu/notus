//
//  tools_tab_view.swift
//  notus
//
//  Created by Sebastian Negulescu on 2026-05-15.
//

import SwiftUI

struct PencilToolView: View {
    @State var stroke_weight = 50.0
    var body: some View {
        VStack {
            Image(systemName: "pencil.and.scribble")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .padding(.bottom, 20)
            
            Text("Colour")
            HStack {
                Image(systemName: "circle.fill")
                Image(systemName: "circle.circle.fill")
                Image(systemName: "circle.fill")
            }
            .padding(1)
            HStack {
                Image(systemName: "circle.fill")
                Image(systemName: "circle.fill")
                Image(systemName: "plus.circle")
            }
            .padding(1)
            
            Spacer()
            
            Text("Weight")
            HStack {
                Image(systemName: "scribble")
                    .fontWeight(.ultraLight)
                Image(systemName: "scribble")
                    .fontWeight(.light)
                Image(systemName: "scribble")
                    .fontWeight(.medium)
                Image(systemName: "scribble")
                    .fontWeight(.bold)
                Image(systemName: "scribble")
                    .fontWeight(.black)
            }
            .padding(1)
            
            Spacer()
        }
        .padding(20)
        .frame(width: 160, height: 300)
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(.black, lineWidth: 2))
    }
}

struct EraserToolView: View {
    var body: some View {
        VStack {
            Image(systemName: "eraser")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .padding(.bottom, 20)
            Text("Size")
            HStack {
                Image(systemName: "circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10, height: 10)
                Image(systemName: "circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                Image(systemName: "circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 14, height: 14)
                Image(systemName: "circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                Image(systemName: "x.square.fill")
            }
            Spacer()
            
        }
        .padding(20)
        .frame(width: 160, height: 300)
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(.black, lineWidth: 2))
    }
}

struct ToolsTabView: View {
    let tab_offset: UInt
    init(tab_offset: UInt) {
        self.tab_offset = tab_offset
    }
    
    var content: some View {
        HStack {
            VStack {
                Text("Primary")
                    .font(.title2)
                PencilToolView()
            }
            .padding(20)
            .frame(maxWidth: .infinity)
            Rectangle()
                .fill(.black)
                .frame(width: 2, height: 400)
            VStack {
                Text("Secondary")
                    .font(.title2)
                EraserToolView()
            }
            .padding(20)
            .frame(maxWidth: .infinity)
        }
    }
    
    var body: some View {
        TabView(tab_offset: self.tab_offset, colour: .green, content: content)
    }
}
