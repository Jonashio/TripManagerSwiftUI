//
//  LoadingView.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 26/7/22.
//

import SwiftUI

struct LoadingView: View {
    
    private struct Constants {
        static let fontTitle = Font.custom("Muli-SemiBold", size: 25)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            ProgressView("Fetching...")
                .font(Constants.fontTitle)
                .foregroundColor(Color.black)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "000000", alpha: 0.5))
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
