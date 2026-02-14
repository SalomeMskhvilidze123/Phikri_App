//
//  ThoughtCell.swift
//  PhikriApp
//
//  Created by Mcbook Pro on 14.02.26.
//

import Foundation
import SwiftUI
import PhikriDomain //

public struct ThoughtCell: View {
    let title: String
    let bodyText: String
    let moodColor: Color
    
    public init(title: String, bodyText: String, moodColor: Color) {
        self.title = title
        self.bodyText = bodyText
        self.moodColor = moodColor
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Capsule()
                .fill(moodColor)
                .frame(width: 40, height: 4)
            
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(bodyText)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)
        }
        .padding(AppSpacing.medium)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(AppRadius.medium)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
    struct ThoughtCell_Previews: PreviewProvider {
        static var previews: some View {
            ThoughtCell(
                title: "ტესტ ფიქრი",
                bodyText: "თუ ამას ხედავ, პრევიუ მუშაობს!",
                moodColor: Color.blue
            )
            .padding()
            .previewLayout(.sizeThatFits)
        }
    }
}
