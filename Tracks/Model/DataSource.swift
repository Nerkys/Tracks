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
            [Statistics(title: "макс. скорость", image: "MaxSpeed", value: 80),
                 Statistics(title: "расстояние", image: "Distance", value: 1200),
                 Statistics(title: "спусков", image: "NumberOfTracks", value: 17),
                 Statistics(title: "на горе", image: "ActivityTime", value: 80),
                 Statistics(title: "время спуска", image: "ActivityTime", value: 40),
                 Statistics(title: "skillcoin", image: "SkillCoin", value: 110)]
            ),
        
        Season(
            title: "СЕЗОН 2019/20",
            trip:
                [Trip(title: "Куршевель, Франция", startedAt: "2020.02.13", finishedAt: "2020.02.20", image: "France")],
            statistics:
                [Statistics(title: "макс. скорость", image: "MaxSpeed", value: 75),
                 Statistics(title: "расстояние", image: "Distance", value: 600),
                 Statistics(title: "спусков", image: "NumberOfTracks", value: 8),
                 Statistics(title: "на горе", image: "ActivityTime", value: 40),
                 Statistics(title: "время спуска", image: "ActivityTime", value: 10),
                 Statistics(title: "skillcoin", image: "SkillCoin", value: 55)]
            ),
        Season(
        title: "СЕЗОН 2019/20",
        trip:
            [Trip(title: "Куршевель, Франция", startedAt: "2020.02.13", finishedAt: "2020.02.20", image: "France")],
        statistics:
            [Statistics(title: "макс. скорость", image: "MaxSpeed", value: 75),
             Statistics(title: "расстояние", image: "Distance", value: 600),
             Statistics(title: "спусков", image: "NumberOfTracks", value: 8),
             Statistics(title: "на горе", image: "ActivityTime", value: 40),
             Statistics(title: "время спуска", image: "ActivityTime", value: 10),
             Statistics(title: "skillcoin", image: "SkillCoin", value: 55)]
        ),
        Season(
        title: "СЕЗОН 2019/20",
        trip:
            [Trip(title: "Куршевель, Франция", startedAt: "2020.02.13", finishedAt: "2020.02.20", image: "France")],
        statistics:
            [Statistics(title: "макс. скорость", image: "MaxSpeed", value: 75),
             Statistics(title: "расстояние", image: "Distance", value: 600),
             Statistics(title: "спусков", image: "NumberOfTracks", value: 8),
             Statistics(title: "на горе", image: "ActivityTime", value: 40),
             Statistics(title: "время спуска", image: "ActivityTime", value: 10),
             Statistics(title: "skillcoin", image: "SkillCoin", value: 55)]
        )
    ]
}

