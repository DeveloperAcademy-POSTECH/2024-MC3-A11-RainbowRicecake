//
//  StructureSectionView.swift
//  YouTalkAwesome
//
//  Created by 문인범 on 7/30/24.
//

import SwiftUI

struct StructureSectionView: View {
    let topContent: String
    let bottomContent: String
    let isScript: Bool
    
    var body: some View {
        ZStack {
            if self.isScript {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 0.4)
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.gray)
            }
            
            VStack(spacing: 4) {
                Text(topContent)
                    .font(.title)
                    .padding(.top, 12)
                
                Text(bottomContent)
                    .padding(10)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}
