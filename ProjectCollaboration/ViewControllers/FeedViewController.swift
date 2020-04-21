//
//  FeedViewController.swift
//  ProjectCollaboration
//
//  Created by Liubov Kaper  on 4/21/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    private var feedView = FeedView()
    
    override func loadView() {
        view = feedView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureCV()
    }
    
    private func configureCV() {
        feedView.feedCV.register(FeedCell.self, forCellWithReuseIdentifier: "feedCell")
        feedView.feedCV.dataSource = self
        feedView.feedCV.delegate = self
    }

}

extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedCell", for: indexPath)
        cell.backgroundColor = .systemGray
        return cell
    }
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = feedView.safeAreaLayoutGuide.layoutFrame.size
        let itemWidth = maxSize.width
        let itemHeight = maxSize.height * 0.70
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
         collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 20
     }
}
