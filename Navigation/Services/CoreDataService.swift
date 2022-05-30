//
//  CoreDataService.swift
//  Navigation
//
//  Created by a.agataev on 25.05.2022.
//

import Foundation
import StorageService
import UIKit
import CoreData

final class CoreDataService {
    
    func read() -> [Post] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PostFavorites")
        do {
            guard let result = try managedContext.fetch(fetchRequest) as? [NSManagedObject] else { return [] }
            return result.compactMap { data -> Post in
                return Self.makePost(data: data)
            }
            
        } catch let error {
            print("Failed to fetch posts \(error.localizedDescription)")
            return []
        }
    }
    
    func save(post: Post) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let postFavoritesEntity = NSEntityDescription.entity(forEntityName: "PostFavorites", in: managedContext)!
        let postFavorites = NSManagedObject(entity: postFavoritesEntity, insertInto: managedContext)
        postFavorites.setValue(post.author, forKey: "author")
        postFavorites.setValue(post.image, forKey: "image")
        postFavorites.setValue(post.description, forKey: "depiction")
        postFavorites.setValue(post.likes, forKey: "likes")
        postFavorites.setValue(post.views, forKey: "views")

        do {
            try managedContext.save()
            print("Succesfully save")
        } catch let error {
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    static func makePost(data: NSManagedObject) -> Post {
        return Post(
            author: data.value(forKey: "author") as! String,
            image: data.value(forKey: "image") as! String,
            description: data.value(forKey: "depiction") as! String,
            likes: data.value(forKey: "likes") as! Int,
            views: data.value(forKey: "views") as! Int
        )
    }
}
