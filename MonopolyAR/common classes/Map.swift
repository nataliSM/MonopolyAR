//
//  Map.swift
//  MonopolyAR
//
//  Created by Наталья on 11.12.2017.
//  Copyright © 2017 ru.itis.iosLab. All rights reserved.
//

import ARKit

struct Map {
    var positions: [Position] = []
    
    func position(for currentPosition: Int, step: Int) -> Position {
        var endPosition = currentPosition + step
        var stepsToStart = positions.count - 1 - currentPosition
        if step > stepsToStart {
            endPosition = step - stepsToStart
        }
        if currentPosition + step > 39 {
            return positions[0]
        }
        return positions[endPosition]
    }
    init() {
        let mapDict = [1: ("Start", int2(11, -11)),
                       2: ("mediter-ranean avenue", int2(8, -11)),
                       3: ("community chest", int2(6, -11)),
                       4: ("baltic avenue", int2(4, -11)),
                       5: ("income tax", int2(2, -11)),
                       6: ("reading railroad", int2(0, -11)),
                       7: ("orintal avenue", int2(-2, -11)),
                       8: ("chance", int2(-4, -11)),
                       9: ("vermont avenue", int2(-6, -11)),
                       10: ("connecticut avenue", int2(-8, -11)),
                       11: ("in jail", int2(-11, -11)),
                       12: ("st.charles place", int2(-11, -8)),
                       13: ("electric company", int2(-11, -6)),
                       14: ("states avenue", int2(-11, -4)),
                       15: ("virginia avenue", int2(-11, -2)),
                       16: ("pennsylvania railroad", int2(-11, 0)),
                       17: ("st.james place", int2(-11, 2)),
                       18: ("community chest 2", int2(-11, 4)),
                       19: ("tennessee avenue", int2(-11, 6)),
                       20: ("new york avenue", int2(-11, 8)),
                       21: ("free parking", int2(-11, 11)),
                       22: ("kentucky avenue", int2(-8, 11)),
                       23: ("chance 2", int2(-6, 11)),
                       24: ("indiana avenue", int2(-4, 11)),
                       25: ("illinois avenue", int2(-2, 11)),
                       26: ("b&o railrod", int2(0, 11)),
                       27: ("atlantic avenue", int2(2, 11)),
                       28: ("ventnor avenue", int2(4, 11)),
                       29: ("water works", int2(6, 11)),
                       30: ("marvin gardens", int2(8, 11)),
                       31: ("go to jail", int2(11, 11)),
                       32: ("pacific avenue", int2(11, 8)),
                       33: ("north california avenue", int2(11, 6)),
                       34: ("community chest 3", int2(11, 4)),
                       35: ("pennsylvania avenue", int2(11, 2)),
                       36: ("short line", int2(11, 0)),
                       37: ("chance 3", int2(11, -2)),
                       38: ("park place", int2(11, -4)),
                       39: ("luxury tax", int2(11, -6)),
                       40: ("boardwalk", int2(11, -8))
            ]
        let sorted = mapDict.sorted { $0.key < $1.key }

        for (_, (name, position)) in sorted {
            let position = Position(name: name, coordinare: position)
            positions.append(position)
        }
        
    }
}
