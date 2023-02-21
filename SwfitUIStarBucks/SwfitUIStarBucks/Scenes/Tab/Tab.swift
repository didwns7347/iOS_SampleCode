//
//  Tab.swift
//  SwfitUIStarBucks
//
//  Created by yangjs on 2023/02/21.
//

import SwiftUI

enum Tab{
    case home
    case other
    //assositatevalue
    var tabTextItem: Text{
        switch self{
        case .home: return Text("Home")
        case .other: return Text("Other")
        }
    }
    
    var tabImageItem: Image{
        switch self{
        case .home: return  Image(systemName: "house.fill")
        case .other: return Image(systemName: "ellipsis")
        }
    }
}
