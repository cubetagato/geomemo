//
//  SeedMemoViewController.swift
//  geomemo
//
//  Created by Gabriel I. Hernández G. on 17/04/17.
//  Copyright © 2017 Gabriel I. Hernández G. All rights reserved.
//

import UIKit

class SeedMemoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var tapTitleLabel: UILabel?
    @IBOutlet var tapImageView: UIImageView?
    
    let contentAlertController: UIAlertController = UIAlertController(title: "What do you want to seed?", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
    let imagePickerController: UIImagePickerController = UIImagePickerController()
    
    var imageStore: ImageStore?
    var seedStore: SeedStore?
    
    var newSeed: Seed?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        super.loadView()
        
        title = "SEED"
        
        view.backgroundColor = UIColor.green
        
        tapTitleLabel!.text = "TAP TO SEED"

        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: #selector(imageTapped))
        tapGestureRecognizer.numberOfTapsRequired = 1
        
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        tapImageView!.image = UIImage(named: "archive")
        tapImageView!.addGestureRecognizer(tapGestureRecognizer)
        tapImageView!.isUserInteractionEnabled = true
        
        contentAlertController.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: { (action) in self.optionSelectedCamera(action: action) } ))
        contentAlertController.addAction(UIAlertAction(title: "Picture/Video", style: UIAlertActionStyle.default, handler: optionSelectedImageVideo ))
        contentAlertController.addAction(UIAlertAction(title: "Message", style: UIAlertActionStyle.default, handler: { (action) in print("Message") } ))
        contentAlertController.addAction(UIAlertAction(title: "Audio", style: UIAlertActionStyle.default, handler: { (action) in print("Auidio") } ))
        contentAlertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (action) in print("Cancel") } ))
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func imageTapped (gesture: UITapGestureRecognizer) {
        switch gesture.state    {
        case .began:
            print("Gesture began")
        case UIGestureRecognizerState.cancelled:
            print("Gesture cnacelled")
        case UIGestureRecognizerState.changed:
            print("Gesture changed")
        case UIGestureRecognizerState.failed:
            print("Gesture failed")
        case UIGestureRecognizerState.ended:
            print("Gestrure End")
            present(contentAlertController, animated: true, completion: {
                print("Ven a la luz...!!")
            })
        default:
            print("Gesture Default")
        }
    }
    
    func optionSelectedCamera(action: UIAlertAction)    {
        print("Camera")
        //if the device has a camera, take a picture. Otherwise just pick from phpto gallery
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)  {
            imagePickerController.sourceType = UIImagePickerControllerSourceType.camera
            imagePickerController.cameraOverlayView = UIImageView(image: UIImage(named: "placeholder"))
        } else{
            imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        }
        
        present(imagePickerController, animated: true, completion: {print("Camera selected controller presented")})
        
    }
    
    func optionSelectedImageVideo(action: UIAlertAction)    {
        print("Picture/Video")
        
        imagePickerController.allowsEditing = false;
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePickerController.mediaTypes = UIImagePickerController.availableMediaTypes(for: UIImagePickerControllerSourceType.photoLibrary)!
        
        present(imagePickerController, animated: true, completion: {
            print("picture/video selected controller presented")
        })
        
    }
    
    /*
     //MARK UIImagePickerControllerDelegate
 */

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("imagePickerController")
        if let choosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //newSeed = Seed(seedObject: choosenImage, seedType: Seed.SeedType.image)
            newSeed = Seed(seedType: Seed.SeedType.image)
            imageStore!.setImage(choosenImage, forKey: newSeed!.id)
            
            let newSeedViewController = NewSeedViewController(nibName: "NewSeedView", bundle: nil)
            newSeedViewController.newSeed = newSeed
            
            dismiss(animated: true, completion: nil)
            
            navigationController!.pushViewController(newSeedViewController, animated: true)
            
        } else{
            print("Error")
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print ("imagePickerControllerDidCancel")
        dismiss(animated: true, completion: nil)
    }
}
