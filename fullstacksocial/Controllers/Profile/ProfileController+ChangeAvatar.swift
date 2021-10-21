//
//  ProfileController+ChangeAvatar.swift
//  fullstacksocial
//
//  Created by wizz on 10/18/21.
//


import UIKit
import JGProgressHUD
import Alamofire

extension ProfileController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func changeProfileImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            dismiss(animated: true) {
                self.uploadUserProfileImage(image: selectedImage)
            }
        } else {
            dismiss(animated: true)
        }
    }
    
    fileprivate func uploadUserProfileImage(image: UIImage) {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Updating profile"
        hud.show(in: view)
        
        let url = "\(Service.shared.baseUrl)/profile"
        
//        AF.upload(multipartFormData: { formData in
//
//            // post text
//            formData.append(Data(text.utf8), withName: "postBody")
//
//            // post image
//            guard let imageData = self.selectedImage.jpegData(compressionQuality: 0.5) else { return }
//            formData.append(imageData, withName: "imagefile", fileName: "DoesntMatterSoMuch", mimeType: "image/jpg")
//
//        }, to: url, method: .post,headers: headers)
//            .uploadProgress(queue: .main, closure: { progress in
//                print("Upload Progress : \(progress.fractionCompleted)")
//                hud.progress = Float(progress.fractionCompleted)
//                hud.textLabel.text = "Uploading\n\(Int(progress.fractionCompleted * 100))% Complete"
//            })
//            .responseJSON(completionHandler: { res in
//            print("maybe finished uploading")
//            print(res)
//
//            }).response { response in
//
//                hud.dismiss()
//                switch response.result {
//                   case .success(let resut):
//                        print("upload success result: \(String(describing: resut))")
//                        self.dismiss(animated: true) {
//                            self.homeController?.fetchPosts()
//                        }
//
//                   case .failure(let err):
//                       print("upload err: \(err)")
//                   }
//                }
                
        AF.upload(multipartFormData: { (formData) in
            guard let user = self.user else { return }
            
            formData.append(Data(user.fullName.utf8), withName: "fullName")
            let bioData = Data((user.bio ?? "").utf8)
            formData.append(bioData, withName: "bio")
            
            guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
            formData.append(imageData, withName: "imagefile", fileName: "DoesntMatterSoMuch", mimeType: "image/jpg")
            
        }, to: url).responseData { dataResp in
            hud.dismiss()
            
            if let err = dataResp.error {
                print("Failed to hit server:", err)
            }
            
            if let code = dataResp.response?.statusCode, code >= 300 {
                print("Failed upload with status: ", code)
                return
            }
            
            print("Successfully updated user profile")
            
            self.fetchUserProfile()
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
}
