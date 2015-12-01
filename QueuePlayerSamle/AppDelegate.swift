//
//  AppDelegate.swift
//  QueuePlayerSamle
//
//  Created by Denis Melenevsky on 30/11/15.
//  Copyright © 2015 Denis Melenevsky. Some rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationDidEnterBackground(application: UIApplication) {
		if self.managedObjectContext.hasChanges {
			do {
				try self.managedObjectContext.save()
			} catch {
				print("Error saving data:", error)
			}
		}
    }
	

	lazy var managedObjectContext: NSManagedObjectContext = {
		let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
		context.persistentStoreCoordinator = self.persistentStoreCoordinator
		return context
	}()

	lazy var managedObjectModel: NSManagedObjectModel = {
		let modelUrl = NSBundle.mainBundle().URLForResource("Model", withExtension: "momd")
		let model = NSManagedObjectModel(contentsOfURL: modelUrl!)!
		return model
	}()
	
	lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
		let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
		let storeUrl = self.applicationDocumentsDirectory().URLByAppendingPathComponent("Model.sqlite")
		
		do {
			try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeUrl, options: nil)
		} catch {
			print("Error: ", error);
			do {
				try NSFileManager.defaultManager().removeItemAtURL(storeUrl)
				try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeUrl, options: nil)
			} catch let anotherError {
				print("Error: ", anotherError);
			}
		}
		
		return coordinator
	}()
	
	func applicationDocumentsDirectory() -> NSURL {
		return NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).first!
	}
	
	func saveContext() {
		if self.managedObjectContext.hasChanges {
			do {
				try self.managedObjectContext.save()
			} catch let error {
				print("Error: ", error)
			}
		}
	}
}

