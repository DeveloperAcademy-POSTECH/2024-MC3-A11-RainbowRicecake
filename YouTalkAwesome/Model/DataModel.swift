//
//  DataModel.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 7/26/24.
//

import SwiftUI
import SwiftData
import Foundation

enum ModelSchemaV0: VersionedSchema {
    static var versionIdentifier = Schema.Version(0, 1, 0)
    
    static var models: [any PersistentModel.Type] {
        [LogicalSpeakingRecord.self]
    }
    
    @Model
    final class LogicalSpeakingRecord{
        var id: UUID
        var topic: String
        var speakingStructure: SpeakingStructure
        var content : [StructureSection]
        var duration: Int
        var isDone: Bool
        var designatedTimestamp : Date?
        var isFreeTopic: Bool
        
        init (id: UUID = UUID(), topic: String, speakingStructure: SpeakingStructure, content: [StructureSection], duration: Int, isDone: Bool, designatedTimestamp: Date? = nil, isFreeTopic : Bool ) {
            self.id = id
            self.topic = topic
            self.speakingStructure = speakingStructure
            self.content = content
            self.duration = duration
            self.isDone = isDone
            self.designatedTimestamp = designatedTimestamp
            self.isFreeTopic = isFreeTopic
        }
    }
}
