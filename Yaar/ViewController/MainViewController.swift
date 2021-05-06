//
//  ViewController.swift
//  Yaar
//
//  Created by Abdul Rahim on 29/04/21.
//

import UIKit
import CryptoSwift


class MainViewController: UIViewController {

    
    @IBOutlet weak var entertf: UITextField!
    @IBOutlet weak var startAuth: UIButton!
    @IBOutlet weak var fetchAttemepts: UIButton!
    @IBOutlet weak var attemptsLabel: UILabel!
    @IBOutlet weak var fetchDifficulty: UIButton!
    @IBOutlet weak var currentLabel: UILabel!
    
    
    //var menu:SideMenuNavigationController?
    let transiton = SlideInTransition()
    let viewModel = AuthViewModel()
    let dataStoreViewModel = DataStoreViewModel()
    var firstName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        viewModel.getDifficulty()
    }
    
    func setupView() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "space")!)
        let img = UIImage(named: "space")
        navigationController?.navigationBar.setBackgroundImage(img, for: .default)
        navigationController?.navigationItem.title = "MainViewController"

        let menuButton = UIButton(type: .system)
        menuButton.setImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
        menuButton.tintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
        menuButton.addTarget(self, action: #selector(didTapMenu), for: .touchDown)
        NotificationCenter.default.addObserver(self, selector: #selector(closeMenu), name: Notification.Name("close"), object: nil)

        
        fetchDifficulty.addTarget(self, action: #selector(didTapDifficulty), for: .touchDown)
        fetchAttemepts.addTarget(self, action: #selector(didTapAttempts), for: .touchDown)
        startAuth.addTarget(self, action: #selector(didTapStart), for: .touchDown)
        entertf.delegate = self
        
    }
    
    @objc func closeMenu() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapStart() {
        if (entertf.text?.count == 0) {
            AlertBuilder.failureAlertWithMessage(message: "Enter Uri to connect!")
        } else {
            UserDefaults.standard.set(entertf.text, forKey:"path")
            viewModel.generatePrimes(to: 262143, url: entertf.text ?? "")
        }
    }
    
    @objc func didTapDifficulty() {
        if entertf.text?.count == 0 {
            AlertBuilder.failureAlertWithMessage(message: "Enter Uri to connect!")
        } else {
            viewModel.getDifficulty()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.currentLabel.text = String(" Current difficulty: \(self.viewModel.difficulty)")
            }
        }
    }
    
    @objc func didTapAttempts() {
        if entertf.text?.count == 0 {
            AlertBuilder.failureAlertWithMessage(message: "Enter Uri to connect!")
        } else {
            viewModel.getCurrentAttempts()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.attemptsLabel.text = " Current attempts: \(self.viewModel.attempts)"
            }
        }
    }
    
    @objc func didTapMenu() {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "DataStoreViewController") as? DataStoreViewController else { return }
    
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        dismiss(animated: true, completion: nil)
    }
    
    
    deinit {
        print("denit was called")
    }


}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension MainViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}
