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
    final class LogicalSpeakingRecord { 
        var id: UUID
        var topic: String
        var logicalStructureName: String
        var content : [String]
        var duration: Int
        var isDone: Bool
        var timestamp : Date
        
        init (id: UUID = UUID(), topic: String, logicalStructureName: String, content: [String],duration: Int, isDone: Bool, timestamp: Date ) {
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
