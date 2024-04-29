//
//  ZMMScoreVC.swift
//  mm
//
//  Created by zhuyn on 2024/2/19.
//

import UIKit
import SnapKit

class ZMMScoreVC: UIViewController {

    @IBOutlet weak var contentBgView: UIView!
    @IBOutlet weak var recordBgView: UIView!
    @IBOutlet weak var optionsBgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }


    func configUI() {
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: <#T##UIImage?#>, style: <#T##UIBarButtonItem.Style#>, target: <#T##Any?#>, action: <#T##Selector?#>)
        
        let recordView = ZMMScoreRecordView()
        recordBgView.addSubview(recordView)
        recordView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        let optionsView = ZMMScoreOptionsView()
        optionsBgView.addSubview(optionsView)
        optionsBgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    
    
}
