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
    final class LogicalSpeakingRecord {
        var id: UUID
        var topic: String
        var logicalStructure: LogicalStructure
        var content : [String]
        var duration: Int
        var isDone: Bool
        var designatedTimestamp : Date?
        
        init (id: UUID = UUID(), topic: String, logicalStructure: LogicalStructure, content: [String],duration: Int, isDone: Bool, designatedTimestamp: Date? = nil ) {
            self.id = id
            self.topic = topic
            self.logicalStructure = logicalStructure
            self.content = content
            self.duration = duration
            self.isDone = isDone
            self.designatedTimestamp = designatedTimestamp
        }
    }
}
