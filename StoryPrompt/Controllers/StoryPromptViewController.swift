//
//  StoryPromptViewController.swift
//  StoryPrompt
//
//  Created by fredrick osuala on 10/04/2021.
//

import UIKit

class StoryPromptViewController: UIViewController {
    
    var storyPrompt : StoryPromptEntry?
    var isNewStoryPrompt = false
    
    @IBOutlet weak var storyPromptText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storyPromptText.text = storyPrompt?.description
        if isNewStoryPrompt{
            let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveStoryPrompt))
            let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelStoryPrompt))
            navigationItem.rightBarButtonItem = saveButton
            navigationItem.leftBarButtonItem = cancelButton
        }
    }
    
    @objc func cancelStoryPrompt(_ sender: UIButton) {
        performSegue(withIdentifier: "CancelStoryBoard", sender: nil)
    }
    @objc func saveStoryPrompt(_ sender: UIButton) {
      //  NotificationCenter.default.post(name: .StoryPromptSaved, object: storyPrompt)
        performSegue(withIdentifier: "SaveStoryPrompt", sender: nil)
    }
    
}

//extension Notification.Name{
//    static let StoryPromptSaved = Notification.Name("StoryPromptSaved")
//}
