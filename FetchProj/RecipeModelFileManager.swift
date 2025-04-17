//
//  RecipeModelFileManager.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/15/25.
//

import Foundation
import SwiftUI

class RecipeModelFileManager {
    
    static let instance = RecipeModelFileManager()
    let folderName = "downloaded_photos"
    
    private init() {
        createFolderIfNeeded()
    }
    
    private func createFolderIfNeeded() {
        guard let url = getFolderPath() else {
            return
        }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
                print("created Folder")
            } catch let error {
                print("error creating foler: \(error)")
            }
        }
    }
    
    private func getFolderPath() -> URL? {
        return FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
    }
    
    private func getImagePath(key: String) -> URL? {
        guard let folder = getFolderPath() else {
            return nil
        }
        return folder.appendingPathComponent(key + ".png")
    }
    
    func add(key: String, value: UIImage) async {
        guard let data = value.pngData(),
              let url = getImagePath(key: key) else {
            return
        }
        Task.detached(priority: .background) {
            do {
                try data.write(to: url)
            } catch let error {
                print("error adding image to file manager \(error)")
            }
        }
    }
    
    func get(key: String) async -> UIImage? {
        guard let url = getImagePath(key: key),
              FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        return await Task.detached(priority: .background) {
            return UIImage(contentsOfFile: url.path)
        }.value
    }
    
    func removeAllImages() {
        guard let folder = getFolderPath() else {
            return
        }
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: folder, includingPropertiesForKeys: nil)
            for file in contents {
                try FileManager.default.removeItem(at: file)
            }
        } catch {
            print("Error removing cached images: \(error)")
        }
    }
}
