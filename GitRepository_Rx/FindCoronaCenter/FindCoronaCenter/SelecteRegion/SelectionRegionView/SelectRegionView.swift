//
//  SelectRegionView.swift
//  FindCoronaCenter
//
//  Created by yangjs on 2023/02/20.
//

import SwiftUI

struct SelectRegionView: View {
    @ObservedObject var viewModel = SelectRegionViewModel()
    
    private var items : [GridItem]{
        Array(repeating: .init(.flexible(minimum:80 )), count: 2)
    }
    let data = Array(1...1000).map { "목록 \($0)"}
    
    //화면을 그리드형식으로 꽉채워줌
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns: items, spacing: 20) {
                    ForEach(Center.Sido.allCases, id:\.id){ sido in
                        let centers = viewModel.centers[sido] ?? []
                        NavigationLink(destination: CenterList(centers:centers)) {
                            SelectRegionItem(region: sido, count: centers.count)
                        }
          
                    }
                }

                .padding()
                .navigationTitle("코로나19 예방접종")
            }
        }
    }
}

struct SelectRegionView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = SelectRegionViewModel()
        
        SelectRegionView(viewModel: vm)
    }
}
