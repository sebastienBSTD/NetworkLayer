//
//  FakeModels.swift
//  NetworkLayerTests
//
//  Created by Pierre on 18/11/2022.
//

@testable import NetworkLayer
import Foundation

class FakeModels {
    static let ads = [
        Ad(id: 1461267313,
                 categoryID: 4,
                 title: "Statue homme noir assis en plâtre polychrome",
                 description: "Magnifique Statuette",
                 price: 140,
                 imagesURL: ImagesURL(small: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/2.jpg",
                                      thumb: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/2.jpg"),
                 creationDate: "2019-11-05T15:56:59+0000",
                 isUrgent: false,
                 siret: nil),
        Ad(id: 1691247255,
                 categoryID: 8,
                 title: "Pc portable hp elitebook 820 g1 core i5 4 go ram 250 go hdd",
                 description: "PC PORTABLE HP",
                 price: 199,
                 imagesURL: ImagesURL(small: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/6.jpg",
                                      thumb: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/6.jpg"),
                 creationDate: "2019-10-16T17:10:20+0000",
                 isUrgent: false,
                 siret: nil)
        ]
        
    static let categories = [
        Category(id: 1, name: "Véhicule"),
        Category(id: 8, name: "Multimédia")
    ]
    
    
//    let bundle = Bundle(for: ModelTests.self)
//    let url = bundle.url(forResource: "Ads", withExtension: "json")!
//    let json = try! Data(contentsOf: url)
}
