//
//  PhotoFilterViewController.swift
//  Core Image Filter Reference
//
//  Created by Hector Villasano on 10/29/20.
//

import UIKit

class PhotoFilterViewController: UIViewController {
    @IBOutlet var pictureImageView: UIImageView!
    
    let imageName = "image.png"
    
    let context = CIContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pictureImageView.image = fetch()
    }
    
    @IBAction func getImageButtonPressed(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @IBAction func filterButtonPressed(_ sender: Any) {
        guard let image = pictureImageView.image else { return }
        
        var ciImage = CIImage(cgImage: image.cgImage!)
            
//        ciImage = ciImage.applyingFilter(CoreImageFilters.CIColorSpace.rawValue, parameters: ["": ])

        //        ciImage = ciImage.applyingFilter(CoreImageFilters.CIColorCubeWithColorSpace.rawValue, parameters: ["inputCubeDimension": 100, "inputCubeData": Data(), "inputColorSpace": CGColorSpace()]) // 2.0 - 128

//        ciImage = ciImage.applyingFilter(CoreImageFilters.CIColorInvert.rawValue)
//        ciImage = ciImage.applyingFilter(CoreImageFilters.CIColorMap.rawValue, parameters: ["inputGradientImage": ciImage])
//        ciImage = ciImage.applyingFilter(CoreImageFilters.CIColorMonochrome.rawValue, parameters: ["inputColor": CIColor(color: .blue), "inputIntensity": 0.5])
//        ciImage = ciImage.applyingFilter(CoreImageFilters.CIColorPosterize.rawValue, parameters: ["inputLevels": 4.5])
//        ciImage = ciImage.applyingFilter(CoreImageFilters.CIFalseColor.rawValue, parameters: [ "inputColor0": CIColor(color: .orange), "inputColor1" : CIColor(color: .red)])
//        ciImage = ciImage.applyingFilter(CoreImageFilters.CIMaskToAlpha.rawValue)
//        ciImage = ciImage.applyingFilter(CoreImageFilters.CISepiaTone.rawValue, parameters: [ "inputIntensity": 0.5])
//        ciImage = ciImage.applyingFilter(CoreImageFilters.CIVignette.rawValue, parameters: ["inputRadius": 0.5 ,"inputIntensity": 0.5])
//        ciImage = ciImage.applyingFilter(CoreImageFilters.CIVignetteEffect.rawValue, parameters: ["inputCenter": CIVector(x: 100, y: 50), "inputIntensity": 0.15, "inputRadius": 0.05])
        
        let cgImage = context.createCGImage(ciImage, from: ciImage.extent)!
        let filteredImage = UIImage(cgImage: cgImage, scale: image.scale, orientation: .up)
        pictureImageView.image = filteredImage
        
    }
    
    func save(image: UIImage) {
        guard let imageData = image.pngData() else { return }
        UserDefaults.standard.set(imageData, forKey: "Image")
    }
    
    func fetch() -> UIImage {
        guard let imageData = UserDefaults.standard.data(forKey: "Image"),
              let image = UIImage(data: imageData) else  { return UIImage() }
        
        return image
    }
    
}

extension PhotoFilterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        dismiss(animated: true)
        save(image: image)
        pictureImageView.image = image
    }
}
