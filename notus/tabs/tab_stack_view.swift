//
//  TabStackView.swift
//  notus
//
//  Created by Sebastian Negulescu on 2026-03-15.
//

import SwiftUI

struct TabStackView: View {
    @Binding var background: BackgroundInfo
    
    var body: some View {
        ZStack (alignment: .topTrailing) {
            InfoTabView(tab_offset: 0)
            ToolsTabView(tab_offset: 1)
            PaperTabView(tab_offset: 2, background: $background)
        }
    }
}
