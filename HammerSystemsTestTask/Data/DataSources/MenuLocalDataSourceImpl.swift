//
//  MenuLocalDataSourceImpl.swift
//  HammerSystemsTestTask
//
//  Created by Артём on 25.07.2025.
//

import Foundation

class MenuLocalDataSourceImpl: MenuLocalDataSource {
    func fetchPizzas() -> [Pizza] {
        return [
            Pizza(
                image: "Pizza1",
                name: "Ветчина и грибы",
                description: "Ветчина, шампиньоны, увеличенная порция моцареллы, томатный соус",
                price: "от 345 р",
                category: .pizza
            ),
            Pizza(
                image: "Pizza2",
                name: "Баварские колбаски",
                description: "Баварские колбаски, ветчина, пикантная пепперони, острая чоризо, моцарелла, томатный соус",
                price: "от 345 р",
                category: .pizza
            ),
            Pizza(
                image: "Pizza3",
                name: "Нежный лосось",
                description: "Лосось, томаты черри, моцарелла, соус песто",
                price: "от 345 р",
                category: .pizza
            ),
            Pizza(image: "Pizza4",
                  name: "Пицца четыре сыра",
                  description: "Соус Карбонара, Сыр Моцарелла, Сыр Пармезан, Сыр Рокфорти, Сыр Чеддер (тёртый)",
                  price: "от 345 р",
                  category: .pizza
                 )
        ]
    }
}
