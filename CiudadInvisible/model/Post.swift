//
//  Post.swift
//  CiudadInvisible
//
//  Created by Mathias on 10/07/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class Post: NSObject {

    var titulo : String! = nil
    var distancia : String! = nil
    var imagen : UIImage! = nil
    
    init() {
        super.init()
    }
    
    init(titulo : String, distancia : String, imagen : UIImage) {
        super.init()
        
        self.titulo = titulo
        self.distancia = distancia
        self.imagen = imagen
        
    }
}
