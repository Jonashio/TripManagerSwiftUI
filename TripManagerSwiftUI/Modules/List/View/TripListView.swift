//
//  TripListView.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 24/7/22.
//

import SwiftUI
import MapKit

struct TripListView: View {
    
    @ObservedObject var viewModel: TripListViewModel = TripListViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Map(coordinateRegion: $viewModel.coordinateRegion)
                    .frame(maxWidth: .infinity, maxHeight: 350)
                
                ScrollView(.vertical) {
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            viewModel.fetch() { response in
                
            }
        }
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        TripListView()
    }
}
