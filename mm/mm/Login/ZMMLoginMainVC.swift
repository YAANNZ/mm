//
//  ZMMLoginMainVC.swift
//  mm
//
//  Created by zhuyn on 2024/2/21.
//

import UIKit

class ZMMLoginMainVC: UIViewController {

    @IBOutlet weak var videoBgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    
    
    @IBAction func signInEvent(_ sender: Any) {
        let signInVC = ZMMSignInVC()
        self.navigationController?.pushViewController(signInVC, animated: true)
        
    }
    
    
    
    @IBAction func signUpEvent(_ sender: Any) {
        
        
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
