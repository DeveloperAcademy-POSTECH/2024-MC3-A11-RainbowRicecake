//
//  DataModel.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 7/26/24.
//

import SwiftUI
import SwiftData

enum ModelSchemaV0: VersionedSchema {
    
    static var versionIdentifier = Schema.Version(0, 1, 0)
    
    static var models: [any PersistentModel.Type] {
        [LogicalSpeakingRecord.self]
    }

    @Model
    class LogicalSpeakingRecord { // final 을 붙여서 좋은 점이 뭐였지? s
        @Attribute(.unique) var id : UUID
        var topic: String
        var logicalStructureName: String
        var content : [String]
        var duration: Duration
        var isDone: Bool
        var timestamp : Date
        
        init (id: UUID = UUID(), topic: String, logicalStructureName: String, content: [String],duration: Duration, isDone: Bool, timestamp: Date ) {
            self.id = id
            self.topic = topic
            self.logicalStructureName = logicalStructureName
            self.content = content
            self.duration = duration
            self.isDone = isDone
            self.timestamp = timestamp
        }
    }

}
