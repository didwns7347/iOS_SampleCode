//
//  FindCoronaCenterApp.swift
//  FindCoronaCenter
//
//  Created by yangjs on 2023/02/20.
//

import SwiftUI

@main
struct FindCoronaCenterApp: App {
    var body: some Scene {
        WindowGroup {
            SelectRegionView(viewModel: SelectRegionViewModel())
        }
    }
}
