//
//  TestView.swift
//  SwiftUIEX
//
//  Created by yangjs on 2022/05/27.
//

import SwiftUI

struct TestView: View {
    let helloFont: Font
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).font(helloFont)
        Text("Let's Go Show")
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(helloFont: .title)
    }
}
