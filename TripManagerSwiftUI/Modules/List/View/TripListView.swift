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
                MapView(routesLocation: $viewModel.routesLocation, needRefresh: $viewModel.needMapRefresh) { idx in
                    print("Jonas en el view: \(idx)")
                    viewModel.loadDetailView(idx)
                }.frame(maxWidth: .infinity, maxHeight: 350)
                
                ScrollView(.vertical) {
                    VStack(spacing: 0) {
                        Text("Trips list")
                            .font(Constants.fontTitle)
                            .padding()
                        if $viewModel.list.count > 0 {
                            ForEach(0..<$viewModel.list.count) { idx in
                                TripListViewCell(model: $viewModel.list[idx], selected: viewModel.selectedIndex == idx) {
                                    viewModel.generateRouteInMap(idx)
                                }
                                Divider()
                            }
                        }
                    }.frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.bottom, 30)
            }
            
            if !viewModel.detailData.name.isEmpty {
                DetailView(data: $viewModel.detailData) {
                    viewModel.detailData = (name: "", time: "", type: "")
                }
            }
            
            switch viewModel.stateEvents {
            case .loading:
                LoadingView()
            case .error:
                ErrorView(close: viewModel.getActionHiddenError())
            case .normal:
                EmptyView()
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
