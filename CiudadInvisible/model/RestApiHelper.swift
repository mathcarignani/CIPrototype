//
//  RestApiHelper.swift
//  CiudadInvisible
//
//  Created by Mathias on 05/07/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import MapKit

class RestApiHelper: NSObject {

    let manager = AFHTTPRequestOperationManager()
    //let urlApi = "http://ciudadinvisible.herokuapp.com/"
    let urlApi = "http://localhost:3000/"
    
    // MARK: Singleton
    class func sharedInstance() -> RestApiHelper! {
        struct Static {
            static var instance: RestApiHelper? = nil
            static var onceToken: dispatch_once_t = 0
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = self()
        }
        return Static.instance!
    }
    
    @required init() {
        
    }
    
    // MARK: Private methods
    func getPosts() {
        
        /*
        manager.GET("http://ciudadinvisible.herokuapp.com/posts.json",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                println("Json obtenido => " + responseObject.description)
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                println("Error")
            })
        */
    }
    
    func getPostsSlider() -> NSArray {
        
        // PRUEBA
        let coordenada = CLLocationCoordinate2D(latitude: -34.9087458, longitude: -56.1614022137041)
        
        let post1 = Post(titulo: "El cierre", distancia: "400 m", imagen: UIImage(named: "bg1.jpg"), coordenada: coordenada)
        let post2 = Post(titulo: "La marilyn", distancia: "500 m", imagen: UIImage(named: "bg2.jpg"), coordenada: coordenada)
        let post3 = Post(titulo: "La plaza", distancia: "700 m", imagen: UIImage(named: "bg3.jpg"), coordenada: coordenada)
        let post4 = Post(titulo: "Melburne", distancia: "10 km", imagen: UIImage(named: "bg4.jpg"), coordenada: coordenada)
        
        return [post1, post2, post3, post4]

    }
    
    func createPost(post: Post) {
        
        //let imageAux = post.images.objectAtIndex(0) as UIImage
        
        var imagesData = [] as Array
        // Recorre las imagenes y agrega
        for image in post.images as Array {
            var imageDictionary = [
                "data": encodeToBase64String(image as UIImage),
                "filename": "\(post.title).png",
                "content_type": "image/png"
            ]
            imagesData += imageDictionary
        }
        
        var parameters = [
            "post":
                [
                    "title":post.title,
                    "author":post.author,
                    "description":post.descriptionText
            ],
            "assets_images": imagesData
        ] as Dictionary
       
        manager.POST("\(urlApi)/posts.json", parameters: parameters, success:
            { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                println("Exito => " + responseObject.description)
                
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                println("Error => " + error.localizedDescription)
            })

    }
    
    // MARK: Auxiliar
    func encodeToBase64String(image: UIImage) -> String {
        return UIImagePNGRepresentation(image).base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
    }

}
