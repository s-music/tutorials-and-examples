//
//  SplashViewController.swift
//  ToDoList
//
//  Created by stone on 2018/01/22.
//  Copyright © 2018年 stone. All rights reserved.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
    
    // MARK: Class fields
    @IBOutlet weak var logoImageView: UIImageView!
    
    // MARK: View lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /**
     *  Viewが表示された後に呼ばれるメソッド
     */
    override func viewDidAppear(_ animated: Bool) {
        //少し縮小するアニメーション
        UIView.animate(withDuration: 0.3,
                       delay: 1.0,
                       options: .curveEaseOut,
                       animations: { () in self.logoImageView.transform = self.logoImageView.transform.scaledBy(x: 0.7, y: 0.7)},
                       completion: nil)
        //拡大させて、消えるアニメーション
        UIView.animate(withDuration: 0.2,
                       delay: 1.3,
                       options: .curveEaseOut,
                       animations: { () in self.logoImageView.transform = self.logoImageView.transform.scaledBy(x: 2.0, y: 2.0)},
                       // 画面からロゴを削除したremoveした後ToDoListViewControllerへ遷移
            completion: { (Bool) in self.logoImageView.removeFromSuperview(); self.moveContentsViewController() }
        )
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Local functions
    ///
    /// アプリのコンテンツ画面へ遷移するメソッド
    ///
    private func moveContentsViewController() {
        let storyBoard = self.storyboard!
        let toDoListViewcontroller = storyBoard.instantiateViewController(withIdentifier: "MainViewController")
        toDoListViewcontroller.modalPresentationStyle = .fullScreen
        present(toDoListViewcontroller, animated: true, completion: nil)
    }
    
}

