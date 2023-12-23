// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftData

public class Utils {
    
    public static func getSchema() -> Schema {
        let schema = Schema([
            DB.ActionEvent.self,
            DB.ColumnDescription.self,
            DB.ColumnLayoutElement.self,
            DB.ColumnLayoutGroup.self,
            DB.CourtPosition.self,
            DB.Division.self,
            DB.EMail.self,
            DB.Event.self,
            DB.EventDetailTypes.self,
            DB.EventTypes.self,
            DB.Game.self,
            DB.GameOfficials.self,
            DB.GameRosterEntry.self,
            DB.GameStatObject.self,
            DB.GameTeamInfo.self,
            DB.Image.self,
            DB.League.self,
            DB.Logo.self,
            DB.Notes.self,
            DB.Official.self,
            DB.Player.self,
            DB.ScoreAdjustment.self,
            DB.Season.self,
            DB.Site.self,
            DB.SubEvent.self,
            DB.Team.self,
            DB.TimeEvent.self,
            DB.Tournament.self,
            DB.User.self,
            DB.Version.self,
            DB.WeightSystem.self,
            DB.WeightSystemEntry.self,
            DB.WeightType.self,
        ])
        return schema
    }
    
    public static func getSchemaV0() -> Schema {
        let schema = Schema([
            ModelsSchemaV0.ActionEvent.self,
            ModelsSchemaV0.ColumnDescription.self,
            ModelsSchemaV0.ColumnLayoutElement.self,
            ModelsSchemaV0.ColumnLayoutGroup.self,
            ModelsSchemaV0.CourtPosition.self,
            ModelsSchemaV0.Division.self,
            ModelsSchemaV0.EMail.self,
            ModelsSchemaV0.Event.self,
            ModelsSchemaV0.EventDetailTypes.self,
            ModelsSchemaV0.EventTypes.self,
            ModelsSchemaV0.Game.self,
            ModelsSchemaV0.GameOfficials.self,
            ModelsSchemaV0.GameRosterEntry.self,
            ModelsSchemaV0.GameStatObject.self,
            ModelsSchemaV0.GameTeamInfo.self,
            ModelsSchemaV0.Image.self,
            ModelsSchemaV0.League.self,
            ModelsSchemaV0.Logo.self,
            ModelsSchemaV0.Notes.self,
            ModelsSchemaV0.Official.self,
            ModelsSchemaV0.Player.self,
            ModelsSchemaV0.ScoreAdjustment.self,
            ModelsSchemaV0.Season.self,
            ModelsSchemaV0.Site.self,
            ModelsSchemaV0.SubEvent.self,
            ModelsSchemaV0.Team.self,
            ModelsSchemaV0.TimeEvent.self,
            ModelsSchemaV0.Tournament.self,
            ModelsSchemaV0.User.self,
            ModelsSchemaV0.Version.self,
            ModelsSchemaV0.WeightSystem.self,
            ModelsSchemaV0.WeightSystemEntry.self,
            ModelsSchemaV0.WeightType.self,
        ])
        return schema
    }
}
