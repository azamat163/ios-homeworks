//
//  PostAPI.swift
//  Navigation
//
//  Created by Азамат Агатаев on 06.11.2021.
//

import Foundation
import StorageService

enum EmptyDataError: Error {
    case emptydata
}

extension EmptyDataError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .emptydata:
            return "Не удалось загрузить посты!"
        }
    }
}

final class PostAPI {
    func fetchPosts(_ completion: @escaping (Result<[Post], EmptyDataError>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let posts = Self.getPosts() else {
                completion(.failure(.emptydata))
                return
            }
            completion(.success(posts))
        }
    }
    
    static func fakeEmptyPosts() -> [Post]? {
        return nil
    }
    
    static func getPosts() -> [Post]? {
        let posts = [
            Post(
                id: "1",
                author: "vedmak.official",
                image: "vedmak",
                description: "Новые кадры со съемок второго сезона сериала 'Ведьмак'",
                likes: 240,
                views: 312
            ),
            Post(
                id: "2",
                author: "Нетология. Меряем карьеру через образование.",
                image: "netology",
                description: "От ' Hello, World' до первого сложного iOS-приложения - всего один курс. Если чувствуете в себе силу для покорения топов AppStore - пора начинать действовать! Профессия 'iOS-разработчик' - тот самый путь, по которому стоит пройти до самого конца. Вы научитесь создавать приложения на языке Swift с нуля: от начинки до интерфейса. Чтобы закрепить знания на практике, каждый студент подготовит дипломную работу - VK-like приложения с возможностью публиковать фотографии, использовать фильтры, ставить лайки и подписываться на других пользователей",
                likes: 766,
                views: 893
            ),
            Post(
                id: "3",
                author: "vc.ru",
                image: "vc",
                description: "«Сбер» продаст часть дочерних банков в Европе с активами на €7,3 млрд",
                likes: 450,
                views: 1500
            ),
            Post(
                id: "4",
                author: "Хабр",
                image: "habr",
                description: "Как я получил офферы в Google, Amazon, Microsoft, Яндекс и Box, не завалив ни одного собеседования (ну, почти)",
                likes: 10000,
                views: 45000
            )
        ]
        
        return posts
    }
}
