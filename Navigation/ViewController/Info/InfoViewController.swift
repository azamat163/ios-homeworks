//
//  InfoViewController.swift
//  Navigation
//
//  Created by a.agataev on 14.10.2021.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInfo()
    }
    
    private func setupInfo() {
        if let infoView: InfoView = .fromNib() {
            infoView.frame = CGRect(x: 0, y: 30, width: view.frame.size.width, height: view.frame.size.height - 30)
            infoView.alertButton.addTarget(self, action: #selector(clickAlertAction(_:)), for: .touchUpInside)
            view.addSubview(infoView)
        }
    }
    
    @objc func clickAlertAction(_ sender: Any) {
        let alert = UIAlertController(title: .title, message: .message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: .yes, style: .default, handler: { alert -> Void in
            print("Да")
        }
        ))
        alert.addAction(UIAlertAction(title: .no, style: .cancel, handler: { alert -> Void in
            print("Нет")
        }))
        present(alert, animated: true, completion: nil)
    }
}

private extension String {
    static let title = "Сообщение"
    static let message = "Хотите чтобы в консоль вывелся лог, нажмите на Да или Нет"
    static let yes = "Да"
    static let no = "Нет"
}
