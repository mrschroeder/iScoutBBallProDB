//
//  ModelMigrationPlan.swift
//
//
//  Created by Mike Schroeder on 12/6/23.
//

import SwiftData
import Foundation
import SwiftUI

//public enum ModelMigrationPlan: SchemaMigrationPlan {
//    public static var schemas: [any VersionedSchema.Type] {
////        [ModelsSchemaV0.self, ModelsSchemaV1.self, ModelsSchemaV2.self]
//        [ModelsSchemaV0.self, ModelsSchemaV1.self]
//    }
//    
//    public static var stages: [MigrationStage] {
////        [migrateV0toV1, migrateV1toV2]
//        [migrateV0toV1]
//    }
//
////    static let migrateV1toV2 = MigrationStage.custom(
////        fromVersion: ModelsSchemaV1.self,
////        toVersion: ModelsSchemaV2.self,
////        willMigrate: { context in
////            // Player
//////            let trips = try? context.fetch(FetchDescriptor<SampleTripsSchemaV1.Trip>())
//////                      
//////            // De-duplicate Trip instances here...
//////                      
//////            try? context.save()
////        }, didMigrate: nil
////    )
//    
//        static let migrateV0toV1 = MigrationStage.lightweight(
//            fromVersion: ModelsSchemaV0.self,
//            toVersion: ModelsSchemaV1.self
//        )
//  
////    static let migrateV2toV3 = MigrationStage.lightweight(
////        fromVersion: SampleTripsSchemaV2.self,
////        toVersion: SampleTripsSchemaV3.self
////    )
//}
//
// core data initial migration
public enum CDModelMigrationPlan: SchemaMigrationPlan {
    public static var schemas: [any VersionedSchema.Type] {
        [ModelsSchemaV0.self, ModelsSchemaV1.self]
    }
    
    public static var stages: [MigrationStage] {
        [migrateV0toV1]
    }
    
    static let migrateV0toV1 = MigrationStage.custom(
            fromVersion: ModelsSchemaV0.self,
            toVersion: ModelsSchemaV1.self,
            willMigrate: { context in
                // Version
                if let version = try? context.fetch(FetchDescriptor<ModelsSchemaV0.Version>()).first {
                    print("*** version: \(version.model)")
                    if version.model != 38 {
                        print("*** version issue \(version.model)")
                    }
                }
            }, didMigrate: { context in
                // Player
                if let players = try? context.fetch(FetchDescriptor<ModelsSchemaV1.Player>()) {
                    for player in players {
                        print("*** player lastName: \(player.lastName)")
                        print("*** player uuid: \(player.uuid)")
                        player.uuid = UUID().uuidString
                        print("*** updated uuid: \(player.uuid)")
                    }
                }
                try? context.save()
                print("*** done with update")
            }
        )
  }
