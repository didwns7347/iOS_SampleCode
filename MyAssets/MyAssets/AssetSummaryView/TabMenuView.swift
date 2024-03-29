//
//  TabMenuView.swift
//  MyAssets
//
//  Created by yangjs on 2022/06/02.
//

import SwiftUI

struct TabMenuView: View {
    var tabs:[String]
    @Binding var selectedTap: Int
    @Binding var updated: CreditCardAmount?
    
    var body: some View {
        HStack{
            ForEach(0..<tabs.count, id: \.self){row in
                Button(
                    action:{
                        selectedTap = row
                        UserDefaults.standard.set(true, forKey: "creditcard_update_checked")
                    },
                    label: {
                        VStack(spacing:0){
                            HStack{
                                if updated?.id == row{
                                    let checked = UserDefaults.standard.bool(forKey: "creditcard_update_checked")
                                    Circle()
                                        .fill(
                                            !checked ? Color.red:Color.clear
                                        )
                                        .frame(width:6, height: 8)
                                        .offset(x:2, y:-8)
                                }else{
                                    Circle()
                                        .fill(
                                            Color.clear
                                        )
                                        .frame(width:6, height: 8)
                                        .offset(x:2, y:-8)
                                }
                                Text(tabs[row])
                                    .font(.system(.headline))
                                    .foregroundColor(selectedTap == row ? .accentColor:.gray)
                                    .offset(x: -4, y: 0)
                            }
                            .frame(height:52)
                            Rectangle()
                                .fill(
                                    selectedTap == row ? Color.secondary : Color.clear
                                )
                                .frame(height:3)
                                .offset(x: 4, y: 0)
                            
                        }
                       
                    }
                        
                    
                )
                .buttonStyle(PlainButtonStyle())
            }
        }
        .frame(height:52)
    }
}

struct TabMenuView_Previews: PreviewProvider {
    static var previews: some View {
        TabMenuView(tabs: ["지난달 결제","이번달 결제","다음달 결제"], selectedTap: .constant(1), updated: .constant(.currentMonth(amount: "10.000원")))
    }
}
