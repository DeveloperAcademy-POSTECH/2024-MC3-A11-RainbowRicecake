//
//  ArchiveViewModel.swift
//  YouTalkAwesome
//
//  Created by 문인범 on 8/2/24.
//

import Foundation

final class ArchiveViewModel: ObservableObject {
    var offset: CGFloat = 0
    var originOffset: CGFloat = 0
    var isCheckedOriginOffset: Bool = false
    
    func setOriginOffset(_ offset: CGFloat) {
        guard !isCheckedOriginOffset else { return }
        self.originOffset = offset
        isCheckedOriginOffset = true
    }
    
    func setOffset(_ offset: CGFloat) {
        self.offset = offset
    }
}
