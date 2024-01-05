//
//  ContentProvider.swift
//  VoKinoTopShalf
//
//  Created by v.prusakov on 1/4/24.
//

import TVServices

class ContentProvider: TVTopShelfContentProvider {

    override func loadTopShelfContent(completionHandler: @escaping (TVTopShelfContent?) -> Void) {
        
        let sectionItem = TVTopShelfSectionedItem(identifier: UUID().uuidString)
        sectionItem.playbackProgress = 0.4
        sectionItem.title = "Имя Фильма"
        sectionItem.imageShape = .hdtv
        sectionItem.setImageURL(URL(string: "https://cataas.com/cat"), for: .screenScale1x)
        sectionItem.displayAction = TVTopShelfAction(url: URL(string: "https://cataas.com/cat")!)
        let continueWatching = TVTopShelfItemCollection(items: [sectionItem])
        continueWatching.title = "Продолжить просмотр"
        
        let favorites = TVTopShelfItemCollection(items: [sectionItem])
        favorites.title = "Избранное"
        
        let content = TVTopShelfSectionedContent(sections: [continueWatching, favorites])
        
        // Fetch content and call completionHandler
        completionHandler(content);
    }

}

