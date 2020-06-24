//
//  DataSource.swift
//  Tracks
//
//  Created by Mikhail Chukhvantsev on 23.06.2020.
//  Copyright © 2020 Mikhail Chukhvantsev. All rights reserved.
//

import Foundation

func getDataSourceInitialValue() -> [Season] {
    return [
        Season(title: "СЕЗОН 2018/19", resort:
            [
                Trip(title: "Сольдэу - Эль-Тартер, Андорра", statedAt: "2020.02.13", finishedAt: "2020.02.20"),
                Trip(title: "Уистлер-Блэккомб, Канада", statedAt: "2020.03.03", finishedAt: "2020.03.10")]),
        Season(title: "СЕЗОН 2019/20", resort:
            [
                Trip(title: "Куршевель, Франция", statedAt: "2020.02.13", finishedAt: "2020.02.20")])
    ]
}
