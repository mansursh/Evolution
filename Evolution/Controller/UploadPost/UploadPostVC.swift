//
//  ViewController.swift
//  Evolution
//
//  Created by ZAF on 2/28/19.
//  Copyright © 2019 Muzaffar Sharapov. All rights reserved.
//

import UIKit
import Firebase
import ActiveLabel

class UploadPostVC: UIViewController, UITextViewDelegate, ImagePickerDelegate {
    
    // MARK: - Properties
    
    var selectedImage: UIImage? {
        didSet {
            self.photoImageView.image = selectedImage
        }
    }
    
    
    let categoriesSelect = ["","Work Out","Business","Entrepreneur","Finance","Other"]
    
    var selectedCategory: String?
    
//    enum UploadAction: Int {
//        case UploadPost
//        case SaveChanges
//
//        init(index: Int) {
//            switch index {
//            case 0: self = .UploadPost
//            case 1: self = .SaveChanges
//            default: self = .UploadPost
//            }
//        }
//    }
    
  //  var uploadAction: UploadAction!
   // var selectedImage: UIImage?
    var postToEdit: Post?
    
    lazy var photoImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.image = #imageLiteral(resourceName: "upload_image_icon")
        
        
      //  iv.loadImage(with: #imageLiteral(resourceName: "upload_image_icon") )
       
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(handleTapToImage))
        imageTap.numberOfTapsRequired = 1
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(imageTap)
        
        return iv
    }()
    
    let captionTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor.groupTableViewBackground
        tv.font = UIFont.systemFont(ofSize: 12)
        return tv
    }()
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.setTitle("Share", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleUploadPost), for: .touchUpInside)
        return button
    }()
    
    lazy var toggleButton: UISwitch = {
        let toggleButton = UISwitch()
        toggleButton.isOn = false
        toggleButton.onTintColor = .blue
        toggleButton.addTarget(self, action: #selector(handleSwitch), for: .valueChanged)
        return toggleButton
    }()
    
    
    
    //MARK: - Image Tap Guesture
    
    @objc func handleTapToImage(_ sender: UITapGestureRecognizer) {
        
        print("Tapped Image")

//        let selectImage = SelectImageVC(collectionViewLayout: UICollectionViewFlowLayout())
//
//        self.del
//        navigationController?.pushViewController(selectImage, animated: true)
//
        
        let layout = UICollectionViewFlowLayout()
        let selectImage = SelectImageVC(collectionViewLayout: layout)
        selectImage.delegate = self
        let navController = UINavigationController(rootViewController: selectImage)
        
        present(navController, animated: true, completion: nil)
    }
    
    
    //MARK: - Toggle button
    
    @objc func handleSwitch(sender: UISwitch) {
        if sender.isOn {
            print("true")

        }
        else {
            print("false")

        }
    }


    
    
    
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        // configure view components
        configureViewComponents()
        
        // load image
        loadImage()
        
        // text view delegate
        captionTextView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
 //       configureViewController(forUploadAction: uploadAction)
    }
    
    // MARK: - UITextView
    
    func textViewDidChange(_ textView: UITextView) {
        
        guard !textView.text.isEmpty else {
            actionButton.isEnabled = false
            actionButton.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
            return
        }
        
        actionButton.isEnabled = true
        actionButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
    }
    
    
    

    
   
    
    // MARK: - Handlers
    
//    @objc func handleUploadAction() {
//        buttonSelector(uploadAction: uploadAction)
//    }
    
    @objc func handleCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
//    func buttonSelector(uploadAction: UploadAction) {
//        switch uploadAction {
//        case .UploadPost:
//            handleUploadPost()
//        case .SaveChanges:
//            handleSavePostChanges()
//        }
//    }
    
//    func configureViewController(forUploadAction uploadAction: UploadAction) {
//        if uploadAction == .SaveChanges {
//            guard let post = self.postToEdit else { return }
//            actionButton.setTitle("Save Changes", for: .normal)
//            self.navigationItem.title = "Edit Post"
//            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
//            navigationController?.navigationBar.tintColor = .black
//            photoImageView.loadImage(with: post.imageUrl ?? "")
//            captionTextView.text = post.caption
//        } else {
//            actionButton.setTitle("Share", for: .normal)
//            self.navigationItem.title = "Upload Post"
//        }
//    }
    
    func loadImage() {
        guard let selectedImage = self.selectedImage else { return }
        photoImageView.image = selectedImage
    }
    
    func configureViewComponents() {
        view.backgroundColor = .white
        
        view.addSubview(photoImageView)
        photoImageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 92, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
        
        view.addSubview(captionTextView)
        captionTextView.anchor(top: view.topAnchor, left: photoImageView.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 92, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 100)
        
        view.addSubview(actionButton)
        actionButton.anchor(top: photoImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 12, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: 0, height: 40)
        
        view.addSubview(toggleButton)
        toggleButton.anchor(top: actionButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    // MARK: - API
    
    func handleSavePostChanges() {
        guard let post = self.postToEdit else { return }
        guard let updatedCaption = captionTextView.text else { return }
        
        if updatedCaption.contains("#") {
            self.uploadHashtagToServer(withPostId: post.postId)
        }
        
        POSTS_REF.child(post.postId).child("caption").setValue(updatedCaption) { (err, ref) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleUploadPost() {
        
        // paramaters
        guard
            let caption = captionTextView.text,
            let postImg = photoImageView.image,
            let currentUid = Auth.auth().currentUser?.uid else { return }
            let tog = self.toggleButton.isOn
        
        // image upload data
        guard let uploadData = postImg.jpegData(compressionQuality: 0.5) else { return }
        
        // creation date
        let creationDate = Int(NSDate().timeIntervalSince1970)
        
        // update storage
        let filename = NSUUID().uuidString
        let storageRef = STORAGE_POST_IMAGES_REF.child(filename)
        storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
            
            // handle error
            if let error = error {
                print("Failed to upload image to storage with error", error.localizedDescription)
                return
            }
            
            storageRef.downloadURL(completion: { (url, error) in
                guard let imageUrl = url?.absoluteString else { return }
                
                // post data
                let values = ["caption": caption,
                              "creationDate": creationDate,
                              "likes": 0,
                              "imageUrl": imageUrl,
                              "ownerUid": currentUid,
                              "privatePost":tog
                       ]
                    
                    as [String: Any]
                
                // post id
                let postId = POSTS_REF.childByAutoId()
                guard let postKey = postId.key else { return }
                
                // upload information to database
                postId.updateChildValues(values, withCompletionBlock: { (err, ref) in
                    
                    // update user-post structure
                    let userPostsRef = USER_POSTS_REF.child(currentUid)
                    userPostsRef.updateChildValues([postKey: 1])
                    
                    // update user-feed structure
                    self.updateUserFeeds(with: postKey)
                    
                    // upload hashtag to server
                    if caption.contains("#") {
                        self.uploadHashtagToServer(withPostId: postKey)
                    }
                    
                    // upload mention notification to server
                    if caption.contains("@") {
                        self.uploadMentionNotification(forPostId: postKey, withText: caption, isForComment: false)
                    }
                    
                    // return to home feed
                    self.dismiss(animated: true, completion: {
                        self.tabBarController?.selectedIndex = 0
                    })
                })
            })
        }
    }
    
    func updateUserFeeds(with postId: String) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let values = [postId: 1]
        
        USER_FOLLOWER_REF.child(currentUid).observe(.childAdded) { (snapshot) in
            let followerUid = snapshot.key
            USER_FEED_REF.child(followerUid).updateChildValues(values)
        }
        
        USER_FEED_REF.child(currentUid).updateChildValues(values)
    }
    
    func uploadHashtagToServer(withPostId postId: String) {
        guard let caption = captionTextView.text else { return }
        let words: [String] = caption.components(separatedBy: .whitespacesAndNewlines)
        
        for var word in words {
            if word.hasPrefix("#") {
                word = word.trimmingCharacters(in: .punctuationCharacters)
                word = word.trimmingCharacters(in: .symbols)
                
                let hashtagValues = [postId: 1]
                HASHTAG_POST_REF.child(word.lowercased()).updateChildValues(hashtagValues)
            }
        }
    }
}


extension UploadPostVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoriesSelect.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoriesSelect[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedCategory = categoriesSelect[row]
   //     categoryTextField.text = selectedCategory
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        //
        var label: UILabel
        //
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Menlo-Regular", size: 20)
        
        label.text = categoriesSelect[row]
        
        return label
    }
    
    func handleImage(image: UIImage) {
        self.selectedImage = image
    }
}
