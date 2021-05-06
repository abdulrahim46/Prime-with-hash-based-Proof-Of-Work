//
//  DataStoreViewController.swift
//  Yaar
//
//  Created by Abdul Rahim on 01/05/21.
//

import UIKit


class DataStoreViewController: UIViewController {
    
    
    @IBOutlet weak var authTokentf: UITextField!
    @IBOutlet weak var dataStroreBtn: UIButton!
    @IBOutlet weak var enterQueryTf: UITextField!
    @IBOutlet weak var updateQueryBtn: UIButton!
    @IBOutlet weak var validateBtn: UIButton!
    @IBOutlet weak var dataStoreTv: UITextView!
    
    let dataStoreViewModel = DataStoreViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    func setupView() {
        let img = UIImage(named: "space")
        navigationController?.navigationBar.setBackgroundImage(img, for: .default)
        title = "DataStoreViewController"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        

        dataStroreBtn.addTarget(self, action: #selector(didTapDataStore), for: .touchDown)
        updateQueryBtn.addTarget(self, action: #selector(didTapUpdateQuery), for: .touchDown)
        validateBtn.addTarget(self, action: #selector(didTapValidate), for: .touchDown)
        authTokentf.delegate = self
        enterQueryTf.delegate = self
    }
    
    
    @objc func didTapDataStore() {
        let token = UserDefaults.standard.object(forKey: "authToken") as? String ?? ""
        let path = UserDefaults.standard.object(forKey: "path") as? String ?? ""
        dataStoreViewModel.getDataStore(url: path, authToken: token)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.dataStoreTv.text = self.dataStoreViewModel.dataStoreDump.description
        }
    }
    
    @objc func didTapUpdateQuery() {
        let tf = enterQueryTf.text
        let token = UserDefaults.standard.object(forKey: "authToken") as? String ?? ""
        dataStoreViewModel.queryDataStore(authToken: token, query: tf ?? "")
    }
    
    @objc func didTapValidate() {
        let token = UserDefaults.standard.object(forKey: "authToken") as? String ?? ""
        dataStoreViewModel.validate(authToken: token)
    }
    
    deinit {
        print("denit was called")
    }
    
    
}

extension DataStoreViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

