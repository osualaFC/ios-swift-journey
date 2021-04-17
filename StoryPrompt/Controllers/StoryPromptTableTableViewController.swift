//
//  StoryPromptTableTableViewController.swift
//  StoryPrompt
//
//  Created by fredrick osuala on 10/04/2021.
//

import UIKit

class StoryPromptTableTableViewController: UITableViewController {
    
    var storyPrompts = [StoryPromptEntry]()

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storyPrompts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryPromptCell", for: indexPath)
        cell.textLabel?.text = "Prompt\(indexPath.row+1)"
        cell.imageView?.image = storyPrompts[indexPath.row].image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyPrompt = storyPrompts[indexPath.row]
        performSegue(withIdentifier: "StoryPromptTable", sender: storyPrompt)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "StoryPromptTable"{
           guard let vc = segue.destination as? StoryPromptViewController,
                 let storyPrompt = sender as? StoryPromptEntry else {
                return
            }
            vc.storyPrompt = storyPrompt
        }
    }

    @IBAction func saveStoryPrompt(unwindSegue : UIStoryboardSegue){
        guard let vc = unwindSegue.source as? StoryPromptViewController,
              let storyPrompt = vc.storyPrompt else {
            return
        }
        storyPrompts.append(storyPrompt)
        tableView.reloadData()
    }
    
    @IBAction func cancelStoryPrompt(unwindSeque : UIStoryboardSegue){}

}
