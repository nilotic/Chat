// 
//  RoundedShape.swift
//
//  Created by Den Jo on 2021/03/24.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct RoundedShape: Shape {

    // MARK: - Value
    // MARK: Public
    let radius: CGFloat
    let corners: UIRectCorner

    
    // MARK: - Function
    // MARK: Public
    func path(in rect: CGRect) -> Path {
        Path(UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath)
    }
}
