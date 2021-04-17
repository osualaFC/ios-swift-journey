//
//  ViewController.swift
//  StoryPrompt
//
//  Created by fredrick osuala on 20/03/2021.
//

import UIKit
import PhotosUI

class ViewController: UIViewController {

    @IBOutlet weak var nounTextField: UITextField!
    @IBOutlet weak var adjectiveTextField: UITextField!
    @IBOutlet weak var verbTextField: UITextField!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var numberSlider: UISlider!
    @IBOutlet var selectImageView: UIImageView!
    
    var storyPrompt = StoryPromptEntry()
    
    @IBAction func changeNumber(_ sender: UISlider) {
        numberLabel.text = "Number \(Int(sender.value))"
        storyPrompt.number = Int(sender.value)
    }
    
    @IBAction func changeGenre(_ sender: UISegmentedControl) {
        if let genre = StoryPrompts.Genre(rawValue: sender.selectedSegmentIndex){
            storyPrompt.genre = genre
        } else {
            storyPrompt.genre = .scifi
        }
    }
    @IBAction func generatePrompt(_ sender: Any) {
        updatePrompt()
        if storyPrompt.isValid(){
            performSegue(withIdentifier: "StoryPrompt", sender: nil)
        } else {
            let alert = UIAlertController(title: "Invalid StoryPrompt", message: "Please fill out all of the fields", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: {action in})
            alert.addAction(action)
            present(alert, animated: true)
        }
       
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberSlider.value = 7.5
        selectImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeImage))
        selectImageView.addGestureRecognizer(gestureRecognizer)
       // NotificationCenter.default.addObserver(self, selector: #selector(updatePrompt), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    @objc func updatePrompt(){
        storyPrompt.noun = nounTextField.text ?? ""
        storyPrompt.adjective = adjectiveTextField.text ?? ""
        storyPrompt.verb = verbTextField.text ?? ""
    }
    @objc func changeImage(){
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        let controller = PHPickerViewController(configuration: config)
        controller.delegate = self
        present(controller, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StoryPrompt"{
            guard let vc = segue.destination as? StoryPromptViewController else{
                return
            }
            vc.storyPrompt = storyPrompt
            vc.isNewStoryPrompt = true
        }
    }
 
}

extension ViewController :UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updatePrompt()
        return true
    }
}

extension ViewController : PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        if !results.isEmpty{
            let result = results.first!
            let itemProvider = result.itemProvider
            if itemProvider.canLoadObject(ofClass: UIImage.self){
                itemProvider.loadObject(ofClass: UIImage.self){[weak self] image, error in
                    guard let image = image as? UIImage else{return}
                    DispatchQueue.main.async {
                        self?.selectImageView.image = image
                    }
                }
            }
        }
    }
}
