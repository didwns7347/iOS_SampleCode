//
//  MapView.swift
//  FindCoronaCenter
//
//  Created by yangjs on 2023/02/20.
//

import SwiftUI
import MapKit
struct AnnotationItem : Identifiable{
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    var coordination : CLLocationCoordinate2D
    @State private var region = MKCoordinateRegion()
    @State private var annotationItem = [AnnotationItem]()
    
    var body: some View {
        Map(coordinateRegion: $region,
            annotationItems: [AnnotationItem(coordinate: coordination)],
            annotationContent: {
            MapMarker(coordinate: $0.coordinate)
        }).onAppear{
            setRegion(coordination)
            setAnnotationItem(coordination)
        }
    }
    
    private func setRegion(_ coordinate:CLLocationCoordinate2D){
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    }
    
    private func setAnnotationItem(_ coordinate:CLLocationCoordinate2D){
        annotationItem = [AnnotationItem(coordinate: coordinate)]
    }
                                    
                    
                                    
                                    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        let center0 = Center(id: 0, sido: .경기도, facilityName: "실내빙상장 앞", address: "경기도 와와구 와와읍", lat: "37.404476", lng: "126.9491998", centerType: .central, phoneNumber: "010-0000-0000")
        MapView(coordination: CLLocationCoordinate2D(
            latitude: CLLocationDegrees(center0.lat) ?? .zero,
            longitude: CLLocationDegrees(center0.lng) ?? .zero )
        )
    }
}
