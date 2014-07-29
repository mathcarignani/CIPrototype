//
//  Post.swift
//  CiudadInvisible
//
//  Created by Mathias on 10/07/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit
import MapKit

class Post: NSObject {

    var titulo : String! = nil
    var distancia : String! = nil
    var imagen : UIImage! = nil
    var coordenada : CLLocationCoordinate2D! = nil
    
    var id : Int! = nil
    var title : String! = nil
    var author : String! = nil
    var descriptionText : String! = nil
    var date : NSDate! = nil
    var location : String! = nil
    var category : String! = nil
    var images : NSArray! = nil
    var url : String! = nil
    
    
    init() {
        super.init()
    }
    
    init(titulo : String, distancia : String, imagen : UIImage, coordenada: CLLocationCoordinate2D) {
        super.init()
        
        self.titulo = titulo
        self.distancia = distancia
        self.imagen = imagen
        self.coordenada = coordenada
        
    }

}
