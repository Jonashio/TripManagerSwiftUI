//
//  TripListView.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 24/7/22.
//

import SwiftUI
import MapKit

struct TripListView: View {
    
    private struct Constants {
        static let fontTitle = Font.custom("Muli-Bold", size: 25)
    }
    
    @ObservedObject var viewModel: TripListViewModel = TripListViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Map(coordinateRegion: $viewModel.coordinateRegion)
                    .frame(maxWidth: .infinity, maxHeight: 350)
                
                ScrollView(.vertical) {
                    VStack(spacing: 0) {
                        Text("Trips list")
                            .font(Constants.fontTitle)
                            .padding()
                        if $viewModel.list.count > 0 {
                            ForEach(0..<$viewModel.list.count) { idx in
                                TripListViewCell(model: $viewModel.list[idx], selected: viewModel.selectedIndex == idx) { uuid in
                                    withAnimation { viewModel.selectedIndex = idx }
                                }
                                Divider()
                            }
                        }else{
                            VStack(alignment: .center) {
                                ProgressView("Fetching...")
                            }.frame(maxWidth: .infinity, minHeight: 150, alignment: .center)
                        }
                    }.frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.bottom, 30)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            viewModel.fetch()
        }
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        TripListView()
    }
}
