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
    let urlApi = "http://ciudadinvisible.herokuapp.com"
    //let urlApi = "http://localhost:3000"
    
    // MARK: - Singleton
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
    
    required override init() {
        
    }
    
    // MARK: - Private methods
    
    // MARK: - Users
    
    func loadUserInformation(userId: Int, completion: (success: Bool) -> ()) {
        
        var user: User! = User()
        
        manager.GET("\(urlApi)/users/\(userId)",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                UserSesionHelper.sharedInstance().saveInDeviceUserLogued(responseObject)
                completion(success: true)
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                println("Error: \(error)")
                completion(success: false)
        })
        
    }
    
    func loginManual(email: String, password: String, completion: (logued: Bool) -> ()) {
        
        // Arma los parametros a enviar
        var parameters = [
                "email":email,
                "password":password
            ] as Dictionary
        
        manager.POST("\(urlApi)/login_common",
            parameters: parameters,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                // Success
                UserSesionHelper.sharedInstance().saveInDeviceUserLogued(responseObject)
                completion(logued: true)
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                completion(logued: false)
            })
    }
    
    func loginFacebook(user: User, completion: (logued: Bool) -> ()) {
        
        // Arma los parametros a enviar
        var parameters = [
            "user":
                [
                    "username":user.email,
                    "email":user.email,
                    "first_name":user.first_name,
                    "last_name":user.last_name,
                    "facebook_id":user.facebook_id
                ]
            ] as Dictionary
        
        manager.POST("\(urlApi)/login_facebook",
            parameters: parameters,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                // Success
                UserSesionHelper.sharedInstance().saveInDeviceUserLogued(responseObject)
                completion(logued: true)
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                completion(logued: false)
            })
    }
    
    func loginTwitter(user: User, completion: (logued: Bool) -> ()) {
        
        // Arma los parametros a enviar
        var parameters = [
            "user":
                [
                    "username":user.email,
                    "email":user.email,
                    "first_name":user.first_name,
                    "last_name":user.last_name,
                    "twitter_id":user.twitter_id
            ]
            ] as Dictionary
        
        manager.POST("\(urlApi)/login_twitter",
            parameters: parameters,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                // Success
                UserSesionHelper.sharedInstance().saveInDeviceUserLogued(responseObject)
                completion(logued: true)
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                completion(logued: false)
        })
    }
    
    func siginManual(user: User, completion: (register: Bool) -> ()) {
        
        // Arma los parametros a enviar
        var parameters = [
            "user":
                [
                    "username":user.email,
                    "email":user.email,
                    "first_name":user.first_name,
                    "last_name":user.last_name,
                    "password":user.password
            ]
            ] as Dictionary
        
        manager.POST("\(urlApi)/register_common",
            parameters: parameters,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                // Success
                UserSesionHelper.sharedInstance().saveInDeviceUserLogued(responseObject)
                completion(register: true)
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                completion(register: false)
            })

        
    }
    
    func followUser(followerId: Int, followedId: Int, completion: (success: Bool) -> ()) {
        
        var parameters = [
                "follower":followerId,
                "followed":followedId
            ] as Dictionary
        
        manager.POST("\(urlApi)/follow_user.json", parameters: parameters, success:
            { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                println("Exito => " + responseObject.description)
                completion(success: true)
                
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                println("Error => " + error.localizedDescription)
                completion(success: false)
        })
    }
    
    // MARK: - Posts
    func getPosts(completion: (posts : NSArray) -> ()) {
        //
        manager.GET("\(urlApi)/posts.json",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                
                var posts : NSMutableArray = NSMutableArray()
                
                // Obtiene los posts
                var postsJson = JSONValue(responseObject)
                let postsJsonCount = postsJson.array!.count
                
                if postsJsonCount > 0 {
                    // Recorre los posts json
                    for i in 0...(postsJsonCount - 1) {
                
                        var post = self.parsePost(postsJson[i])
                        
                        // Agrega el post
                        posts.addObject(post)
                    }
                }
                
                // Ejecuta el bloque con el retorno de los posts
                completion(posts: posts)
    
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                println("Error \(error)")
            })
    }
    
    func getPreferencePosts(completion: (posts : NSArray) -> ()) {

        var parameters = [
            "user_id":UserSesionHelper.sharedInstance().getUserLogued().id
            ] as Dictionary
        
        manager.POST("\(urlApi)/preferences_posts",
            parameters: parameters,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in

                var posts: NSMutableArray = NSMutableArray()
                
                // Obtiene los posts
                var postsJson = JSONValue(responseObject)
                let postsJsonCount = postsJson.array?.count
                
                if postsJsonCount > 0 {
                    // Recorre los posts json
                    for i in 0...(postsJsonCount! - 1) {
                            // Crea el post y lo agrega a la lista
                            var post : Post = Post()
                            post.id = postsJson[i]["id"].integer
                            post.title = postsJson[i]["title"].string
                            post.author = postsJson[i]["author"].string
                            post.descriptionText = postsJson[i]["description"].string
                            post.location = postsJson[i]["location"].string
                            post.category = postsJson[i]["category"].string
                            post.url = postsJson[i]["url"].string
                            post.latitude = postsJson[i]["latitude"].double
                            post.longitude = postsJson[i]["longitude"].double
                            post.author_avatar = postsJson[i]["author_avatar"].string
                            // Agrega las imagenes
                            var auxImages : NSMutableArray = NSMutableArray()
                            let imagesJsonCount = postsJson[i]["assets"].array?.count
                            if imagesJsonCount != 0 {
                                for j in 0...(imagesJsonCount! - 1) {
                                    auxImages.addObject(postsJson[i]["assets"][j]["file_url"].string!)
                                }
                            }
                            post.images = auxImages
                            
                            
                            // Agrega el post
                            posts.addObject(post)

                    }
                }
                
                // Ejecuta el bloque con el retorno de los posts
                completion(posts: posts)
                
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                println("Error \(error)")
        })

    }

    func createPost(post: Post, completion: (success: Bool) -> ()) {
        
        // Primero envía el contenido del post y luego las imagenes
        var user = UserSesionHelper.sharedInstance().getUserLogued()
        
        var parameters = [
            "post":
                [
                    "title":post.title,
                    "description":post.descriptionText,
                    "date":post.date,
                    "location":post.location,
                    "latitude":post.latitude,
                    "longitude":post.longitude,
                    "user_id":user.id
                ]
            ] as Dictionary
        
        manager.POST("\(urlApi)/posts_mobile", parameters: parameters, success:
            { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                println("Exito => " + responseObject.description)
                
                // Asocia las imagenes
                var postsJson = JSONValue(responseObject)
                
                self.addAssetsToPost(postsJson["id"].integer!, post: post)
                
                completion(success: true)
                
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                println("Error => " + error.localizedDescription)
                completion(success: false)
        })
    }
    
    func addAssetsToPost(postId: Int, post: Post) {

        var imagesData: NSMutableArray = NSMutableArray()
        // Recorre las imagenes y agrega
        for image in post.images as Array {
            var imageDictionary = [
                "data": encodeToBase64String(image as UIImage),
                "filename": "\(post.title).png",
                "content_type": "image/png"
            ]
            imagesData.addObject(imageDictionary)
        }
        
        var parameters = [
                "assets_images": imagesData
            ] as Dictionary
        
        manager.POST("\(urlApi)/assets_mobile/\(postId)", parameters: parameters, success:
            { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                println("Exito => " + responseObject.description)
                
                
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                println("Error => " + error.localizedDescription)
                
        })
    }
    
    func favoritePost(postId: Int, userId: Int, completion: (success: Bool) -> ()) {
        
        var user = UserSesionHelper.sharedInstance().getUserLogued()
    
        var parameters = ["post_id":postId,
                    "user_id":userId] as Dictionary
        
        manager.POST("\(urlApi)/favorite.json", parameters: parameters, success:
            { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                println("Favorito Exito => " + responseObject.description)
                completion(success: true)
                
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                println("Favorito Error => " + error.localizedDescription)
                completion(success: false)
        })
        
    }
    
    // MARK: - Tour
    func getRandomTour(coordinate: CLLocationCoordinate2D, completion: (posts : NSArray) -> ()) {
        
        var parameters = [
            "latitude": "\(coordinate.latitude)",
            "longitude": "\(coordinate.longitude)",
            "user_id": "\(UserSesionHelper.sharedInstance().getUserLogued().id)"
            ] as Dictionary
        
        manager.POST("\(urlApi)/random_tour",
            parameters: parameters,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                
                var posts: NSMutableArray = NSMutableArray()
                
                // Obtiene los posts
                var allJson = JSONValue(responseObject)
                var postsJson = allJson["posts"]
                let postsJsonCount = postsJson.array?.count
                
                if postsJsonCount > 0 {
                    // Recorre los posts json
                    for i in 0...(postsJsonCount! - 1) {
                        // Crea el post y lo agrega a la lista
                        var post : Post = Post()
                        post.id = postsJson[i]["id"].integer
                        post.title = postsJson[i]["title"].string
                        post.location = postsJson[i]["location"].string
                        post.latitude = postsJson[i]["latitude"].double
                        post.longitude = postsJson[i]["longitude"].double
                        
                        // Agrega el post
                        posts.addObject(post)
                        
                    }
                }
                
                // Ejecuta el bloque con el retorno de los posts
                completion(posts: posts)
                
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                println("Error \(error)")
        })
        
    }
    
    // MARK: - Categories
    func getCategories(completion: (categories: NSArray) -> ()) {
        var categories: NSMutableArray = NSMutableArray()
        manager.GET("\(urlApi)/categories.json",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                // Obtiene los posts
                var categoriesJson = JSONValue(responseObject)
                let categoriesJsonCount = categoriesJson.array?.count
                
                if categoriesJsonCount > 0 {
                    // Recorre las categorias
                    for i in 0...(categoriesJsonCount! - 1) {
                        
                        // Crea la categoria y la agrega
                        var categoryName = categoriesJson[i]["name"].string
                        
                        // Agrega el post
                        categories.addObject(categoryName!)
                    }
                }
                
                // Ejecuta el bloque con el retorno de los posts
                completion(categories: categories)
                
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                println("Error \(error)")
                completion(categories: categories)
        })
    }
    
    // MARK: - Comments
    func createComment(comment: Comment, completion: (success: Bool) -> ()) {
        
        var user = UserSesionHelper.sharedInstance().getUserLogued()
        
        var parameters = [
            "comment":
                [
                    "text":comment.text,
                    "user_id":user.id,
                    "post_id":comment.post.id
            ]
            ] as Dictionary
        
        println(parameters)
        
        manager.POST("\(urlApi)/comment", parameters: parameters, success:
            { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                println("Exito => " + responseObject.description)
                completion(success: true)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                println("Error => " + error.localizedDescription)
                completion(success: false)
        })
    }

    
    // MARK: - Auxiliar
    func encodeToBase64String(image: UIImage) -> String {
        return UIImagePNGRepresentation(image).base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
    }
    
    func parsePost(postJson: JSONValue) -> Post {
        
        // Crea el post y lo agrega a la lista
        var post : Post = Post()
        post.id = postJson["id"].integer
        post.title = postJson["title"].string
        post.author = postJson["author"].string
        post.descriptionText = postJson["description"].string
        post.location = postJson["location"].string
        post.category = postJson["category"].string
        post.url = postJson["url"].string
        post.latitude = postJson["latitude"].double
        post.longitude = postJson["longitude"].double
        post.favorites_quantity = postJson["favorites_quantity"].integer
        post.userId = postJson["user_id"].integer
        post.author_avatar = postJson["author_avatar"].string
        
        // Agrega las imagenes
        var auxImages: NSMutableArray = NSMutableArray()
        let imagesJsonCount = postJson["assets"].array?.count
        if imagesJsonCount != 0 {
            for j in 0...(imagesJsonCount! - 1) {
                auxImages.addObject(postJson["assets"][j]["file_url"].string!)
            }
        }
        post.images = auxImages
        
        // Agrega los comentarios
        var auxComments: NSMutableArray = NSMutableArray()
        let commentsJsonCount = postJson["comments"].array?.count
        if commentsJsonCount != 0 {
            for j in 0...(commentsJsonCount! - 1) {
                var comment = Comment()
                comment.first_name = postJson["comments"][j]["text"].string!
                comment.first_name = postJson["comments"][j]["first_name"].string!
                comment.last_name = postJson["comments"][j]["last_name"].string!
                comment.username = postJson["comments"][j]["username"].string!
                comment.avatar = postJson["comments"][j]["avatar"].string!
                auxComments.addObject(comment)
            }
        }
        post.comments = auxComments
        return post
    }
    
}
