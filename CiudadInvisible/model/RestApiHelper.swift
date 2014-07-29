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
    func getPosts(completion: (posts : NSArray) ->()) {
        //
        manager.GET("\(urlApi)/posts.json",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                
                var posts : Array = []
                
                // Obtiene los posts
                var postsJson = JSONValue(responseObject)
                let postsJsonCount = postsJson.array?.count as Int
                // Recorre los posts json
                for i in 0...(postsJsonCount - 1) {
            
                    // Crea el post y lo agrega a la lista
                    var post : Post = Post()
                    post.id = postsJson[i]["id"].integer
                    post.title = postsJson[i]["title"].string
                    post.author = postsJson[i]["author"].string
                    post.descriptionText = postsJson[i]["description"].string
                    post.location = postsJson[i]["location"].string
                    post.category = postsJson[i]["category"].string
                    post.url = postsJson[i]["url"].string
                    // Agrega las imagenes
                    var auxImages : Array = []
                    let imagesJsonCount = postsJson[i]["assets"].array?.count
                    for j in 0...(imagesJsonCount! - 1) {
                        auxImages += postsJson[i]["assets"][j]["file_url"].string!
                    }
                    post.images = auxImages
                    
                    
                    // Agrega el post
                    posts += post
                }
                
                // Ejecuta el bloque con el retorno de los posts
                completion(posts: posts)
    
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                println("Error")
            })
    }
    
    func getPost() {
        manager.GET("\(urlApi)/posts/1.json",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                println("Json obtenido => " + responseObject.description)
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                println("Error")
            })

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
