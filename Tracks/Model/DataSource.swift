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
        Season(
            title: "СЕЗОН 2018/19",
            trip:
                [Trip(title: "Сольдэу - Эль-Тартер, Андорра", startedAt: "2020.02.13", finishedAt: "2020.02.20", image: "Andorra"),
                 Trip(title: "Уистлер-Блэккомб, Канада", startedAt: "2020.03.03", finishedAt: "2020.03.10", image: "Canada")],
            statistics:
            [Statistics(title: "макс. скорость", image: "MaxSpeed"),
                 Statistics(title: "расстояние", image: "Distance"),
                 Statistics(title: "спуски", image: "NumberOfTracks"),
                 Statistics(title: "на горе", image: "ActivityTime"),
                 Statistics(title: "время спуска", image: "ActivityTime"),
                 Statistics(title: "skillcoin", image: "SkillCoin")]
            ),
        
        Season(
            title: "СЕЗОН 2019/20",
            trip:
                [Trip(title: "Куршевель, Франция", startedAt: "2020.02.13", finishedAt: "2020.02.20", image: "France")],
            statistics:
                [Statistics(title: "макс. скорость", image: "MaxSpeed"),
                 Statistics(title: "расстояние", image: "Distance"),
                 Statistics(title: "спуски", image: "NumberOfTracks"),
                 Statistics(title: "на горе", image: "ActivityTime"),
                 Statistics(title: "время спуска", image: "ActivityTime"),
                 Statistics(title: "skillcoin", image: "SkillCoin")]
            )
    ]
}

