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
import CoreData

class ViewController: UIViewController, MPMediaPickerControllerDelegate, AVPlayerViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
	
    @IBOutlet weak var chooseButton: UIButton?
	@IBOutlet weak var tableView: UITableView?
	@IBOutlet weak var playerPlaceholderView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		do {
			try self.fetchedResultsController.performFetch()
		} catch let error {
			print("Error: ", error)
		}
		
		self.playerPlaceholderView?.addSubview(playerController.view)
		playerController.view.frame = self.playerPlaceholderView!.bounds
		playerController.videoGravity = AVLayerVideoGravityResize
    }
	
	@IBAction func chooseMusic(sender: UIButton?) {
		let mediaPicker = MPMediaPickerController(mediaTypes: MPMediaType.Music)
		mediaPicker.delegate = self
		mediaPicker.prompt = "Add music to queue"
		mediaPicker.allowsPickingMultipleItems = true
		self.presentViewController(mediaPicker, animated: true, completion: nil)
	}
	
    func mediaPicker(mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
		if let playerItemEntity = NSEntityDescription.entityForName(kPlayerItemEntityName, inManagedObjectContext: self.fetchedResultsController.managedObjectContext) {
			for mediaItem in mediaItemCollection.items {
				let playerItemObject = PlayerItemMO(entity: playerItemEntity, insertIntoManagedObjectContext: self.fetchedResultsController.managedObjectContext)
				playerItemObject.setMediaItem(mediaItem)
			}
		}
		
        mediaPicker.dismissViewControllerAnimated(true) { () -> Void in }
    }
	
	func mediaPickerDidCancel(mediaPicker: MPMediaPickerController) {
		print("mediaPickerDidCancel")
	}
    
    static private let mediaPickerSegueIdentifier = "mediaPickerSegueIdentifier"
    static private let playerSegueIdentifier = "playerSegueIdentifier"
		
	private lazy var fetchedResultsController: NSFetchedResultsController = {
		let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
		
		let fetchRequest = NSFetchRequest()
		fetchRequest.entity = NSEntityDescription.entityForName(kPlayerItemEntityName, inManagedObjectContext: appDelegate.managedObjectContext)
		
		let sortDescriptor = NSSortDescriptor(key: kTitleKey, ascending: true)
		fetchRequest.sortDescriptors = [sortDescriptor]
		
		fetchRequest.fetchBatchSize = 20
		
		let fetchedResults = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate.managedObjectContext, sectionNameKeyPath: kArtistKey, cacheName: "Root")
		fetchedResults.delegate = self
		
		return fetchedResults
	}()
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		/*
		var result = 0
		if let fetchedSections = self.fetchedResultsController.sections {
			result = fetchedSections.count
		}
		return result
		 */
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		var result = 0;
		/*
		if let fetchedSections = self.fetchedResultsController.sections {
			if section < fetchedSections.count {
				result = fetchedSections[section].numberOfObjects
			}
		}
		 */
		
		if let fetchedObjects = self.fetchedResultsController.fetchedObjects {
			result = fetchedObjects.count
		}
		return result
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cellIdentifier = "MusicItemCellIdentifier"
		
		var result: UITableViewCell
		
		let dequedCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
		if dequedCell != nil {
			result = dequedCell!
		} else {
			result = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
		}
		
		let fetchedObject = self.fetchedResultsController.fetchedObjects![indexPath.row]
		if let playerItem = fetchedObject as? PlayerItemMO {
			result.textLabel?.text = playerItem.title
		} else {
			print("no cells for table view");
		}
		
		return result
	}
	
	func controllerDidChangeContent(controller: NSFetchedResultsController) {
		self.tableView?.reloadData()
	}
	
	func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
		self.playerController.player?.pause()
		
		if let fetchedObjects = self.fetchedResultsController.fetchedObjects {
			var playerItems = [AVPlayerItem]()
			
			let addToQueueFromIndex = { (index: Int) in
				let playerItemObject = fetchedObjects[index] as! PlayerItemMO
				if let itemUrl = playerItemObject.itemUrl {
					playerItems.append(AVPlayerItem(URL: itemUrl))
				}
			}
			
			for var index = indexPath.row; index < fetchedObjects.count; index++ {
				addToQueueFromIndex(index)
			}
			
			for var index = 0; index < indexPath.row; index++ {
				addToQueueFromIndex(index)
			}
			
			self.player = AVQueuePlayer(items: playerItems)
			self.playerController.player = self.player
			self.playerPlaceholderView?.addSubview(self.playerController.view)
		}
	}
	
	lazy var playerController = AVPlayerViewController()
	
	var player: AVQueuePlayer?
}

