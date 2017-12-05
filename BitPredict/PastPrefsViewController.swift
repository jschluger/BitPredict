//
//  PastPrefsViewController.swift
//  BitPredict
//
//  Created by eoin on 11/30/17.
//  Copyright © 2017 panna. All rights reserved.
//

import UIKit

class PastPrefsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // data
    var models: Models!
    
    // constants
    let interItemSpacing: CGFloat = 16.0
    let lineSpacing: CGFloat = 16.0
    
    // view elements
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Past Prefrences"
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.register(PastPrefCollectionViewCell.self , forCellWithReuseIdentifier: "PastPrefCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Collection View Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.votes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PastPrefCollectionViewCell", for: indexPath) as! PastPrefCollectionViewCell
        cell.setUpWithVote(models.votes[models.votes.count - indexPath.row - 1])
        return cell
    }
    
    
    // MARK: Collection View Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 2*interItemSpacing, height: view.frame.height / 10 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: lineSpacing, left: interItemSpacing, bottom: lineSpacing, right: interItemSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpacing
    }

}
