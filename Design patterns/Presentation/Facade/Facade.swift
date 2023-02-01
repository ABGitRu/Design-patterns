//
//  Facade.swift
//  Design patterns
//
//  Created by Mac on 23.04.2022.
//

/// выключатель света
final class LightSwitch {
    var toggle = false
}

/// выключатель музыки
final class MusicSwitch {
    var toggle = false
}

/// выключатель видео
final class VideoSwitch {
    var toggle = false
}

/// Фасад всех рубильников
final class EnergyFacade {
    /// рубильник света
    let lightSwitch: LightSwitch
    /// рубильник музыки
    let musicSwitch: MusicSwitch
    /// рубильник видео
    let videoSwitch: VideoSwitch
    /// инициализатор
    /// - parameters:
    /// - lightSwitch: рубильник света
    /// - musicSwitch: рубильник музыки
    /// - videoSwitch: рубильник видео
    init(lightSwitch: LightSwitch, musicSwitch: MusicSwitch, videoSwitch: VideoSwitch) {
        self.lightSwitch = lightSwitch
        self.musicSwitch = musicSwitch
        self.videoSwitch = videoSwitch
    }
    
    /// переключить все рубильники одновременно
    /// - parameters:
    /// - mainPowerIsOn: статус основного рубильника
    func togglePower(mainPowerIsOn: Bool) {
            lightSwitch.toggle = mainPowerIsOn
            musicSwitch.toggle = mainPowerIsOn
            videoSwitch.toggle = mainPowerIsOn
    }
}
