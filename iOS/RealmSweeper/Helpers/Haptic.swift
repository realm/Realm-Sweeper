//
//  Haptic.swift
//  RealmSweeper
//
//  Created by Andrew Morgan on 21/12/2021.
//

import UIKit

func hapticFeedback(_ isSuccess: Bool) {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(isSuccess ? .success : .error)
}
