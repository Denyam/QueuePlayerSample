//
//  ViewController.swift
//  QueuePlayerSamle
//
//  Created by Denis Melenevsky on 30/11/15.
//  Copyright © 2015 Denis Melenevsky. Some rights reserved.
//

import UIKit
import AVKit
import MediaPlayer

class ViewController: UIViewController, MPMediaPickerControllerDelegate, AVPlayerViewControllerDelegate {
    /*
    @IBOutlet weak var mediaPicker: MPMediaPickerController?
    @IBOutlet weak var playerViewController: AVPlayerViewController? {
        return self.storyboard.segu
    }
     */
    
    @IBOutlet weak var chooseButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let segueIdentifier = segue.identifier {
            switch segueIdentifier {
                
            case ViewController.mediaPickerSegueIdentifier:
                if let pickerController = segue.destinationViewController as? MPMediaPickerController {
                    pickerController.delegate = self
                }
                
            default:
                break;
            }
        }
    }
    
    func mediaPicker(mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        for mediaItem in mediaItemCollection.items {
            if let itemUrl = mediaItem.assetURL {
                self.playerItems.append(AVPlayerItem(URL: itemUrl));
            }
        }
        
        mediaPicker.dismissViewControllerAnimated(true) { () -> Void in }
    }
    
    static private let mediaPickerSegueIdentifier = "mediaPickerSegueIdentifier"
    static private let playerSegueIdentifier = "playerSegueIdentifier"
    
    private var playerItems = [AVPlayerItem]()

}

