//
//  AuthViewController.swift
//  Yaar
//
//  Created by Abdul Rahim on 01/05/21.
//

import UIKit
import MatrixSDK


class AuthViewController: UIViewController {

    let riotBotMatrixId = "@yaar-bot:0.0.0.0:1337"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    
    
    func setupView() {
        let img = UIImage(named: "space")
        navigationController?.navigationBar.setBackgroundImage(img, for: .default)
        navigationController?.navigationItem.title = "AuthViewController"
        title = "AuthViewController"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        view.backgroundColor = UIColor(patternImage: UIImage(named: "station")!)
    }
    
    
    
//    func getRooms() {
//        let homeServerUrl = URL(string: "http://0.0.0.0:8008")!
//        let mxRestClient = MXRestClient(homeServer: homeServerUrl, unrecognizedCertificateHandler: nil)
//
//        let d = [String:Any]()
//
//        mxRestClient.register(parameters: d) { response in
//            switch response {
//            case .success(let rooms):
//
//                // rooms is an array of MXPublicRoom objects containing information like room id
//                print("The public rooms are: \(rooms)")
//
//            case .failure(let err):
//                print(err)
//
//            }
//
//        }
//
//
//    }
    
    
//    func creditional() {
//        let credentials = MXCredentials(homeServer: "http://0.0.0.0:8008",
//                                        userId: "@cheeky_monkey:matrix.org",
//                                        accessToken: "abc123")

////        le a = MXKAuthenticationTypeRegister.
//        // Create a matrix client
//        let mxRestClient = MXRestClient(credentials: credentials, unrecognizedCertificateHandler: nil)
//
//        // Create a matrix session
//        let mxSession = MXSession(matrixRestClient: mxRestClient)
//
//        // Make the matrix session open the file store
//        // This will preload user's messages and other data
//        let store = MXFileStore()
//        // Create DM room with Riot-bot
//        let roomCreationParameters = MXRoomCreationParameters(forDirectRoomWithUser: riotBotMatrixId)
//        let httpOperation = mxSession?.createRoom(parameters: roomCreationParameters) { (response) in
//
//
//                            guard response.isSuccess else { return }
//
//                            // mxSession is ready to be used
//                            // now we can get all rooms with:
//
//            print(response.value)
//
//        }
//        mxSession!.setStore(store) { response in
//            guard response.isSuccess else { return }
//
//            // Launch mxSession: it will sync with the homeserver from the last stored data
//            // Then it will listen to new coming events and update its data
//            mxSession!.start { response in
//                guard response.isSuccess else { return }
//
//                // mxSession is ready to be used
//                // now we can get all rooms with:
//               let a = mxSession!.rooms
//                print(a)
//            }
////        }
    
}
