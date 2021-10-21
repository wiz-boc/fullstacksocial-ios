//
//  MainTabBarController.swift
//  fullstacksocial
//
//  Created by wizz on 10/18/21.
//

import UIKit

extension MainTabBarController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            dismiss(animated: true) {
                let createPostController = CreatePostController(selectedImage: image)
                self.present(createPostController, animated: true)
            }
        } else {
            dismiss(animated: true)
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
}

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if viewControllers?.firstIndex(of: viewController) == 1 {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            present(imagePicker, animated: true)
            return false
        }
        
        return true
    }
    
    func refreshPosts() {
        homeController.fetchPosts()
        profileController.fetchUserProfile()
    }
    
    var homeController = HomeController()
    var profileController = ProfileController(userId: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        let vc = UIViewController()
        vc.view.backgroundColor = .yellow
        
        viewControllers = [
            createNavController(viewController: homeController, tabBarImage: #imageLiteral(resourceName: "home")),
            createNavController(viewController: vc, tabBarImage: #imageLiteral(resourceName: "plus")),
            createNavController(viewController: profileController, tabBarImage: #imageLiteral(resourceName: "user"))
        ]
        
        tabBar.tintColor = .black
    }
    
    fileprivate func createNavController(viewController: UIViewController, tabBarImage: UIImage) -> UIViewController {
            
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = tabBarImage
        return navController
        
    }
    
}

