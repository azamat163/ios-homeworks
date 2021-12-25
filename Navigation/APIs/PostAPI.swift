//
//  PostAPI.swift
//  Navigation
//
//  Created by Азамат Агатаев on 06.11.2021.
//

import Foundation
import StorageService

class PostAPI {
    
    static func getPosts() -> [Post] {
        let posts = [
            Post(
                author: "vedmak.official",
                image: "vedmak",
                description: "Новые кадры со съемок второго сезона сериала 'Ведьмак'",
                likes: 240,
                views: 312
            ),
            Post(
                author: "Нетология. Меряем карьеру через образование.",
                image: "netology",
                description: "От ' Hello, World' до первого сложного iOS-приложения - всего один курс. Если чувствуете в себе силу для покорения топов AppStore - пора начинать действовать! Профессия 'iOS-разработчик' - тот самый путь, по которому стоит пройти до самого конца. Вы научитесь создавать приложения на языке Swift с нуля: от начинки до интерфейса. Чтобы закрепить знания на практике, каждый студент подготовит дипломную работу - VK-like приложения с возможностью публиковать фотографии, использовать фильтры, ставить лайки и подписываться на других пользователей",
                likes: 766,
                views: 893
            ),
            Post(
                author: "vc.ru",
                image: "vc",
                description: "«Сбер» продаст часть дочерних банков в Европе с активами на €7,3 млрд",
                likes: 450,
                views: 1500
            ),
            Post(
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
