//
//  DesignSystem.swift
//  PhikriApp
//
//  Created by Mcbook Pro on 12.02.26.
//

import Foundation
import SwiftUI

public enum AppSpacing {
    /// 4 pt
    public static let tiny: CGFloat = 4
    /// 8 pt
    public static let small: CGFloat = 8
    /// 16 pt
    public static let medium: CGFloat = 16
    /// 24 pt
    public static let large: CGFloat = 24
    /// 32 pt
    public static let huge: CGFloat = 32
}

public enum AppRadius {
    /// 8 pt
    public static let small: CGFloat = 8
    /// 12 pt
    public static let medium: CGFloat = 12
    /// 20 pt
    public static let extraLarge: CGFloat = 20
}

// შენი Mood-ფერების პალიტრა
public enum AppColors {
    public static let background = Color(hex: "F8F9FA") 
    public static let accent = Color(hex: "5E60CE") // Phikri-ს მთავარი ფერი
    
    public enum Mood {
        public static let calm = Color(hex: "A2D2FF")
        public static let anxious = Color(hex: "FFD1A9")
        public static let joyful = Color(hex: "FFF5B7")
    }
}
