//
//  ZMMSignInVC.swift
//  mm
//
//  Created by zhuyn on 2024/2/21.
//

import UIKit

class ZMMSignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func enterEvent(_ sender: Any) {
        
        if #available(iOS 15.0, *) {
            let scenes = UIApplication.shared.connectedScenes
            for scene in scenes {
                if (scene.activationState == UIScene.ActivationState.foregroundActive) {
                    let windowScene = scene as! UIWindowScene
                    windowScene.keyWindow?.rootViewController = ZMMTabBarController()
                }
            }
        } else {
            UIApplication.shared.windows.first?.rootViewController = ZMMTabBarController()
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
