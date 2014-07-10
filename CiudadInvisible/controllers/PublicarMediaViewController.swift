//
//  PublicarMediaViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 10/07/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class PublicarMediaViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var previewActual : UIImageView
    @IBOutlet var previewsChica : UIView
    @IBOutlet var previewChica1 : UIImageView
    @IBOutlet var previewChica2 : UIImageView
    @IBOutlet var previewChica3 : UIImageView
    @IBOutlet var previewChica4 : UIImageView
    @IBOutlet var previewChica5 : UIImageView
    
    var imagenes : NSMutableArray = []
    var posicionImagenActual = 0
    
    // MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        self.cargarGestos()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        // Cargo las imagenes en sus correspondientes lugares
        self.cargarImagenesEnPreviews()
        
    }
    
    // MARK: Acciones
    @IBAction func cancelar(sender : AnyObject) {
        self.dismissModalViewControllerAnimated(false)
    }
    
    @IBAction func siguiente(sender : AnyObject) {
        
    }
    
    @IBAction func eliminarActual(sender : AnyObject) {
        
        // Elimina la imagen de la lista 
        self.imagenes.removeObjectAtIndex(self.posicionImagenActual - 1) // El -1 es porque comienza en 0 la lista
        self.cargarImagenesEnPreviews()
        
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        
        // Setea la imagen y cierra el seleccionador
        //previewActual.image = image
        //previewChica1.image = image // CAMBIAR POR LA PREVIEW QUE CORRESPONDA
  
        // Agrega al array de imagenes
        self.imagenes.addObject(image)
        
        picker.dismissModalViewControllerAnimated(true)

    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController!) {
        // Cierra el seleccionador directamente
        picker.dismissModalViewControllerAnimated(true)
    }

    // MARK: Auxiliares
    func cargarGestos() {
        
        let toque1 = UITapGestureRecognizer(target: self, action:Selector("tapEnFoto:"))
        self.previewChica1.userInteractionEnabled = true
        self.previewChica1.addGestureRecognizer(toque1)
        let toque2 = UITapGestureRecognizer(target: self, action:Selector("tapEnFoto:"))
        self.previewChica2.userInteractionEnabled = true
        self.previewChica2.addGestureRecognizer(toque2)
        let toque3 = UITapGestureRecognizer(target: self, action:Selector("tapEnFoto:"))
        self.previewChica3.userInteractionEnabled = true
        self.previewChica3.addGestureRecognizer(toque3)
        let toque4 = UITapGestureRecognizer(target: self, action:Selector("tapEnFoto:"))
        self.previewChica4.userInteractionEnabled = true
        self.previewChica4.addGestureRecognizer(toque4)
        let toque5 = UITapGestureRecognizer(target: self, action:Selector("tapEnFoto:"))
        self.previewChica5.userInteractionEnabled = true
        self.previewChica5.addGestureRecognizer(toque5)

    }
    
    func abrirCamara() {
        var picker : UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        picker.mediaTypes = [kUTTypeImage]
        //picker.allowsEditing = true
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(picker, animated: true, completion: {})
    }
    
    func cargarImagenesEnPreviews() {
        
        // Inicializa las imagenes
        var imageCamara = UIImage(named: "camaraImagen.png")
        self.previewChica1.image = imageCamara
        self.previewChica2.image = imageCamara
        self.previewChica3.image = imageCamara
        self.previewChica4.image = imageCamara
        self.previewChica5.image = imageCamara
        self.previewActual.image = nil
        
        var i = 0
        for image : AnyObject in self.imagenes {
            
            if i == 0 {
                self.previewChica1.image = image as UIImage
                self.previewActual.image = image as UIImage
                self.posicionImagenActual = 1
            } else if i == 1 {
                self.previewChica2.image = image as UIImage
                self.previewActual.image = image as UIImage
                self.posicionImagenActual = 2
            } else if i == 2 {
                self.previewChica3.image = image as UIImage
                self.previewActual.image = image as UIImage
                self.posicionImagenActual = 3
            } else if i == 3 {
                self.previewChica4.image = image as UIImage
                self.previewActual.image = image as UIImage
                self.posicionImagenActual = 4
            } else if i == 4 {
                self.previewChica5.image = image as UIImage
                self.previewActual.image = image as UIImage
                self.posicionImagenActual = 5
            }
            
            i += 1
        }
        
        // Oculto todas y muestro solo las que corresponda
        self.previewChica1.hidden = true
        self.previewChica2.hidden = true
        self.previewChica3.hidden = true
        self.previewChica4.hidden = true
        self.previewChica5.hidden = true
        if i >= 0  {
            // Muestro el 1
            self.previewChica1.hidden = false
        }
        if i >= 1  {
            // Muestro el 1
            self.previewChica2.hidden = false
        }
        if i >= 2  {
            // Muestro el 1
            self.previewChica3.hidden = false
        }
        if i >= 3  {
            // Muestro el 1
            self.previewChica4.hidden = false
        }
        if i >= 4  {
            // Muestro el 1
            self.previewChica5.hidden = false
        }

    }
    
    // MARK: Gestos
    func tapEnFoto(gesture : UITapGestureRecognizer) {

        // Controla a que imagen corresponde el gesto
        let punto = gesture.locationInView(self.previewsChica)
        if (CGRectContainsPoint(self.previewChica1.frame, punto)) {
            // Toque en imagen 1
            if self.imagenes.count() < 1 {
                self.abrirCamara()
            } else {
                // Setea la imagen como actual
                self.previewActual.image = self.previewChica1.image
                self.posicionImagenActual = 1
            }
            
        } else if (CGRectContainsPoint(self.previewChica2.frame, punto)) {
            // Toque en imagen 2
            if self.imagenes.count() < 2 {
                self.abrirCamara()
            } else {
                // Setea la imagen como actual
                self.previewActual.image = self.previewChica2.image
                self.posicionImagenActual = 2
            }
            
        } else if (CGRectContainsPoint(self.previewChica3.frame, punto)) {
            // Toque en imagen 3
            if self.imagenes.count() < 3 {
                self.abrirCamara()
            } else {
                // Setea la imagen como actual
                self.previewActual.image = self.previewChica3.image
                self.posicionImagenActual = 3
            }
            
        } else if (CGRectContainsPoint(self.previewChica4.frame, punto)) {
            // Toque en imagen 4
            if self.imagenes.count() < 4 {
                self.abrirCamara()
            } else {
                // Setea la imagen como actual
                self.previewActual.image = self.previewChica4.image
                self.posicionImagenActual = 4
            }
            
        } else if (CGRectContainsPoint(self.previewChica5.frame, punto)) {
            // Toque en imagen 5
            if self.imagenes.count() < 5 {
                self.abrirCamara()
            } else {
                // Setea la imagen como actual
                self.previewActual.image = self.previewChica5.image
                self.posicionImagenActual = 5
            }
            
        }

    }
    
}
