//
//  ZMMScoreRecordView.swift
//  mm
//
//  Created by zhuyn on 2024/3/1.
//

import UIKit

class ZMMScoreRecordView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    

    var collectionView: UICollectionView!
    var dataAry: Array<Any>!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        configSubViews()
        
        buildData()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configSubViews() {
        let layout = UICollectionViewFlowLayout();
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        layout.itemSize = CGSize(width: 20, height: 20)
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        collectionView = UICollectionView.init(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.register(UINib(nibName: String(describing: ZMMScoreRecordCell.self), bundle: Bundle.main), forCellWithReuseIdentifier: String(describing: ZMMScoreRecordCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    func buildData() {
        var ary = Array<Any>()
        for i in 1...200 {
            ary.append("1")
        }
        dataAry = ary;
        
        collectionView.reloadData()
    }
    
    
    
    
   //MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataAry.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ZMMScoreRecordCell.self), for: indexPath)
        return cell
    }
    
    
    //MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
}
