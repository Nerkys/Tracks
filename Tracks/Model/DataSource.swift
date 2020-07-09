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
                [Trip(title: "Сольдэу - Эль-Тартер", startedAt: "13.02.2020", finishedAt: "20.02.2020", image: "El-Tarter", numberOfActiveDays: 7, numberOfTracks: 17, distance: 1200, flag: "KanadaFlag",
                      statistics:
                            [Statistics(title: "активные дни", image: "NumberOfActiveDays", value: 7),
                             Statistics(title: "спусков", image: "NumberOfTracksWhite", value: 20),
                             Statistics(title: "расстояние", image: "DistanceWhite", value: 700),
                             Statistics(title: "время спуска", image: "ActivityTime", value: 10),
                             Statistics(title: "на горе", image: "ActivityTime", value: 40),
                             Statistics(title: "skillcoin", image: "SkillCoin", value: 55)]),
                
                 Trip(title: "Уистлер-Блэккомб", startedAt: "03.03.2020", finishedAt: "10.03.2020", image: "Blackcomb", numberOfActiveDays: 3, numberOfTracks: 14, distance: 1000, flag: "KanadaFlag",
                      statistics:
                            [Statistics(title: "активные дни", image: "MaxSpNumberOfActiveDayseed", value: 3),
                             Statistics(title: "спусков", image: "NumberOfTracksWhite", value: 8),
                             Statistics(title: "расстояние", image: "DistanceWhite", value: 600),
                             Statistics(title: "время спуска", image: "ActivityTime", value: 10),
                             Statistics(title: "на горе", image: "ActivityTime", value: 40),
                             Statistics(title: "skillcoin", image: "SkillCoin", value: 55)])],
            statistics:
                [Statistics(title: "макс. скорость", image: "MaxSpeed", value: 80),
                 Statistics(title: "расстояние", image: "Distance", value: 1200),
                 Statistics(title: "спусков", image: "NumberOfTracks", value: 17),
                 Statistics(title: "время спуска", image: "ActivityTime", value: 10),
                 Statistics(title: "на горе", image: "ActivityTime", value: 80),
                 Statistics(title: "skillcoin", image: "SkillCoin", value: 110)]
            ),
        
        Season(
            title: "СЕЗОН 2019/20",
            trip:
                [Trip(title: "Куршевель, Франция", startedAt: "14.02.2020", finishedAt: "21.02.2020", image: "Courchevel", numberOfActiveDays: 4, numberOfTracks: 13, distance: 900, flag: "KanadaFlag",
                      statistics:
                            [Statistics(title: "активные дни", image: "MaxSpNumberOfActiveDayseed", value: 5),
                             Statistics(title: "спусков", image: "NumberOfTracksWhite", value: 10),
                             Statistics(title: "расстояние", image: "DistanceWhite", value: 900),
                             Statistics(title: "время спуска", image: "ActivityTime", value: 11),
                             Statistics(title: "на горе", image: "ActivityTime", value: 43),
                             Statistics(title: "skillcoin", image: "SkillCoin", value: 60)])],
            statistics:
                [Statistics(title: "макс. скорость", image: "MaxSpeed", value: 75),
                 Statistics(title: "расстояние", image: "Distance", value: 600),
                 Statistics(title: "спусков", image: "NumberOfTracks", value: 8),
                 Statistics(title: "время спуска", image: "ActivityTime", value: 10),
                 Statistics(title: "на горе", image: "ActivityTime", value: 40),
                 Statistics(title: "skillcoin", image: "SkillCoin", value: 55)]
            )
    ]
}

