//
//  ModelSchema1.swift
//
//
//  Created by Mike Schroeder on 12/5/23.
//

import Foundation
import SwiftData
import UIKit

public enum ModelsSchemaV1: VersionedSchema {
    public static var versionIdentifier = Schema.Version(1, 0, 0)
    public static var models: [any PersistentModel.Type] {
        [ActionEvent.self,
         ColumnDescription.self,
         ColumnLayoutElement.self,
         ColumnLayoutGroup.self,
         CourtPosition.self,
         Division.self,
         EMail.self,
         Event.self,
         EventDetailTypes.self,
         EventTypes.self,
         Game.self,
         GameOfficials.self,
         GameRosterEntry.self,
         GameStatObject.self,
         GameTeamInfo.self,
         Image.self,
         League.self,
         Logo.self,
         Notes.self,
         Official.self,
         Player.self,
         ScoreAdjustment.self,
         Season.self,
         Site.self,
         SubEvent.self,
         Team.self,
         TimeEvent.self,
         Tournament.self,
         User.self,
         Version.self,
         WeightSystem.self,
         WeightSystemEntry.self,
         WeightType.self
        ] }
    
    @Model final public class ActionEvent {
        public var value: Int16 = 0
        var weight: Float = 0
        var detailtype: Int16 = 0
        @Relationship(deleteRule: .cascade, inverse: \CourtPosition.actionEvent) public var courtPosition: CourtPosition? = nil
        public var player: Player? = nil
        @Relationship(minimumModelCount: 1, inverse: \Event.actionEvent) public var event: Event
        
        public init(event: Event) {
            self.event = event
        }
    }
    
    @Model final public class ColumnDescription {
        var defaultAlignment: Int16 = 0
        var statType: Int16 = 0
        var detailType: Int16 = 0
        var maxCharWidth: Int16 = 0
        var glossaryKey: Int16 = 0
        @Relationship(inverse: \ColumnLayoutElement.columnDescription) public var columnLayoutElement: [ColumnLayoutElement] = []
        
        public init() { }
    }
    
    @Model final public class ColumnLayoutElement {
        var visible: Bool = true
        var order: Int16 = 0
        var columnLayoutGroup: ColumnLayoutGroup? = nil
        var columnDescription: ColumnDescription? = nil
        
        public init() { }
    }
    
    @Model final public class ColumnLayoutGroup {
        var key: Int16 = 0
        public var version: Int16 = 0
        @Relationship(deleteRule: .cascade) public var columnLayoutElement: [ColumnLayoutElement] = []
        
        init() { }
    }
    
    @Model final public class CourtPosition {
        var Xcoordinate: Int64 = 0
        var Ycoordinate: Int64 = 0
        public var actionEvent: ActionEvent
        
        public init(actionEvent: ActionEvent) {
            self.actionEvent = actionEvent
        }
    }
    
    @Model final public class Division {
        var name: String = ""
        var divisionId: Int32 = 0
        @Relationship(inverse: \Team.division) public var team: [Team] = []
        
        public init() { }
    }
    
    @Model final public class EMail {
        var address: String = ""
        @Relationship(inverse: \Player.email) public var player: Player? = nil
        @Relationship(inverse: \Team.emailMaxPreps) public var maxPrepsTeam: Team? = nil
        @Relationship(inverse: \Team.emailStatMachine) public var statMachineTeam: Team? = nil
        @Relationship(inverse: \Team.email) public var team: Team? = nil
        
        public init() { }
    }
        
    @Model final public class Event {
        @Attribute(originalName: "type") public var eventType: Int16 = 0
        public var period: Int16 = 0
        public var eventOrder: Int16 = 0
        var logbookEntry: Bool = false
        var targetEventType: Int16 = 0
        public var time: Int16 = 0
        var targetEventDetailType: Int16 = 0
        @Relationship(deleteRule: .cascade) public var actionEvent: ActionEvent? = nil
        @Relationship(deleteRule: .cascade, inverse: \TimeEvent.event) public var timeEvent: TimeEvent? = nil
        public var targetEventCreator: Event? = nil
        @Relationship(deleteRule: .cascade, inverse: \Event.targetEventCreator) public var targetEventReceiver: Event? = nil
        public var team: Team?
        @Relationship(deleteRule: .cascade, inverse: \SubEvent.event) public var subEvent: SubEvent? = nil
        @Relationship(deleteRule: .cascade, inverse: \ScoreAdjustment.event) public var scoreAdjustmentEvent: ScoreAdjustment? = nil
        public var game: Game
        
        public var runningScoreHome: Int = 0
        public var runningScoreAway: Int = 0
        
        init(game: Game) {
            self.game = game
        }
    }
    
    @Model public final class EventDetailTypes {
        public var id: Int16 = 0
        var valueQualifier: Int16? = 0
        var weight: Float? = 0
        var name: String?
        var abbrev: String
        public var eventType: EventTypes
        
        public init(abbrev: String, eventType: EventTypes) {
            self.abbrev = abbrev
            self.id = 0
            self.valueQualifier = 0
            self.weight = 0
            self.name = abbrev
            self.eventType = eventType
        }
    }
    
    @Model final public class EventTypes {
        public var id: Int16 = 0
        var name: String = ""
        var abbrev: String = ""
        @Relationship(deleteRule: .cascade) public var detailType: [EventDetailTypes] = []
        @Relationship(deleteRule: .cascade, inverse: \WeightType.eventType) public var weightType: [WeightType] = []
        
        public init(abbrev: String) {
            self.abbrev = abbrev
        }
    }
    
    @Model final public class Game {
        public var uuid: String = ""
        var updatedAt: Date? = nil
        public var team1isHome: Bool = true
        var pushedToNginDate: Date? = nil
        var timerStopOnSub: Bool = true
        var statsCached: Bool = false
        var gameId: Int32 = 0
        var currentTimeRemaining: Int16 = 0
        var completed: Bool = false
        var timeoutPeriodRange: Int16 = 0
        var syncedToNgin: Bool = true
        var locked: Bool = false
        var timeoutHalfTypeMax: Int16 = 0
        var foulCountPerPlayerLimit: Int16 = 0
        var typeConfTourn: Int16 = 1
        var foulCountBonus: Int16 = 7
        var typePreRegularPlayoff: Int16 = 1
        var awayTeamName: String = ""
        var dataEntryType: Int16 = 0
        var gameSiteNeutral: Bool = false
        var homeTeamName: String = ""
        var resetTimeout: Bool = true
        public var overtimeCount: Int16 = 0
        var timerStopOnFoul: Bool = true
        var currentPeriod: Int16 = 0
        var outsideLaneIs3pt: Bool = false
        public var gameSite: String = ""
        var foulCountDisplayLimit: Int16 = 0
        var pushedToNginState: Int32 = 1
        var overtimeTime: Int16 = 2
        var timeoutShowRemaining: Bool = false
        var status: String = ""
        var dataImportType: Int32 = 0
        var foulResetRange: Int16 = 0
        var attendance: Int32? = 0
        var timeoutFullTypeMax: Int16 = 0
        public var periodCount: Int16 = 4
        var idLarge: String = ""
        var foulCountDoubleBonus: Int16 = 10
        var hiddenFlag: Bool = false
        var periodTime: Int16 = 18
        @Attribute(originalName: "time") public var gameTime: Date
        var timerStopOnJump: Bool = true
        @Relationship(deleteRule: .cascade, inverse: \GameTeamInfo.gameTeam2) public var gameTeam2Info: GameTeamInfo? = nil
        public var season: Season
        var tournament: Tournament? = nil
        @Relationship(deleteRule: .cascade) public var events: [Event] = []
        @Relationship(deleteRule: .cascade, inverse: \GameTeamInfo.gameTeam1) public var gameTeam1Info: GameTeamInfo? = nil
        @Relationship(deleteRule: .cascade, inverse: \GameOfficials.game) public var gameOfficials: GameOfficials? = nil
        @Relationship(deleteRule: .cascade, inverse: \GameStatObject.game) public var gameStatObjects: [GameStatObject] = []
        @Relationship(deleteRule: .cascade, inverse: \Notes.game) public var notes: Notes? = nil
        
        public init(time: Date) {
            self.gameTime = time
        }
    }
    
    @Model final public class GameOfficials {
        var official4: Official? = nil
        var official1: Official? = nil
        var official2: Official? = nil
        var game: Game? = nil
        var official3: Official? = nil
        
        public init() { }
    }
    
    @Model final public class GameRosterEntry {
        var isStartingPlayer: Bool = false
        var activeStatus: Bool = true
        var toBeDeleted: Bool = false
        var syncedToNgin: Bool = false
        var gameTeamInfo: GameTeamInfo? = nil
        var player: Player? = nil
        
        public init() { }
    }
    
    @Model final public class GameStatObject {
        var lineupKey: String = ""
        var valueCategory: Int16 = 0
        var period: Int16 = 0
        var timeIN: Int16 = 0
        @Attribute(originalName: "type") var gameStatObjectType: Int16 = 0
        var value: Int16 = 0
        var detailtype: Int16 = 0
        var player: Player? = nil
        var game: Game? = nil
        var team: Team? = nil
        
        public init() { }
    }
    
    @Model final public class GameTeamInfo {
        var forfeited: Bool = false
        var teamSortMethod: Int16 = 1
        var teamUseAltJersey: Bool = false
        public var teamTrackSubTime: Bool = false
        var defaultShotsMade: Bool = false
        @Relationship(deleteRule: .cascade, inverse: \GameRosterEntry.gameTeamInfo) public var roster: [GameRosterEntry] = []
        var gameTeam1: Game? = nil
        public var team: Team? = nil
        var gameTeam2: Game? = nil
        
        public init() { }
    }
    
    @Model
    final public class Image {
        @Attribute(.transformable(by: "ImageToDataTransformer")) public var image: UIImage? = nil
        @Relationship(inverse: \Player.image) public var player: Player? = nil
        @Relationship(inverse: \Team.image) public var team: Team? = nil
        
        public init() { }
    }
    
    @Model final public class League {
        public var uuid: String = ""
        var idLarge: String = ""
        var divisionId: Int32 = 0
        var seasonId: Int32 = 0
        var divisionName: String = ""
        var demo: Bool = false
        var hiddenFlag: Bool = false
        var dataImportType: Int32 = 0
        public var abbrevName: String = ""
        public var name: String = ""
        var leagueId: Int32 = 0
        @Relationship(inverse: \User.leagues) public var users: [User] = []
        var site: Site? = nil
        @Relationship(deleteRule: .cascade, inverse: \Team.league) public var teams: [Team] = []
        
        public init() { }
    }
    
    @Model final public class Logo {
        @Attribute(.transformable(by: "ImageToDataTransformer")) var image: UIImage? = nil
        @Relationship(inverse: \Team.logo) public var team: Team? = nil
        
        public init() { }
    }
    
    @Model final public class Notes {
        var content: String = ""
        var game: Game? = nil
        
        public init() { }
    }
    
    @Model final public class Official {
        var active: Bool = true
        var firstName: String = ""
        var note: String = ""
        var officialId: Int32 = 0
        var lastName: String = ""
        var gameOfficials4: [GameOfficials] = []
        var gameOfficials2: [GameOfficials] = []
        var gameOfficials3: [GameOfficials] = []
        var gameOfficials1: [GameOfficials] = []
        
        public init() { }
    }
    
    @Model final public class Player {
        public var uuid: String = ""
        public var nickName: String = ""
        var idLarge: String = ""
        public var status: String = ""
        public var playerPosition: Int16 = 0
        var playerId: Int32 = 0
        public var activeStatus: Bool = true
        var starterStatus: Int16 = 1
        var rosterType: Int16 = 0
        var tempPendingSub: Int16 = 0
        var year: Int16 = 0
        var updatedAt: Date? = nil
        var idCode: String = ""
        public var firstName: String = ""
        var syncedToNgin: Bool = true
        public var jerseyNumber: String = ""
        var altJerseyNumber: String = ""
        var dataImportType: Int32 = 0
        public var lastName: String = ""
        var gameStatObjects: [GameStatObject] = []
        @Relationship(inverse: \SubEvent.player4) public var subeventPlayer4: [SubEvent] = []
        @Relationship(deleteRule: .cascade) public var image: DB.Image? = nil
        @Relationship(inverse: \SubEvent.player5) public var subeventPlayer5: [SubEvent] = []
        @Relationship(inverse: \SubEvent.player1) public var subeventPlayer1: [SubEvent] = []
        @Relationship(deleteRule: .cascade) public var gameRosterEntry: [GameRosterEntry] = []
        @Relationship(deleteRule: .cascade) public var email: EMail? = nil
        @Relationship(inverse: \SubEvent.player2) public var subeventPlayer2: [SubEvent] = []
        var actionEvents: [ActionEvent] = []
        @Relationship(inverse: \SubEvent.player3) public var subeventPlayer3: [SubEvent] = []
        public var team: Team? = nil
        
        public init(firstName: String, lastName: String, jerseyNumber: String) {
            self.firstName = firstName
            self.lastName = lastName
            self.jerseyNumber = jerseyNumber
            self.uuid = UUID().uuidString
        }
    }
    
    @Model final public class ScoreAdjustment {
        var scoreValue: Int16 = 0
        var eventPeriod: Int16 = 1
        public var event: Event
        
        public init(event: Event) {
            self.event = event
        }
    }
    
    @Model final public class Season {
        public var uuid: String = ""
        var idLarge: String = ""
        var periodTime: Int16 = 0
        var seasonId: Int32 = 0
        var periodCount: Int16 = 0
        var overtimeTime: Int16 = 0
        var endDate: Date? = nil
        var demo: Bool = false
        var hiddenFlag: Bool = false
        var dataImportType: Int32 = 0
        var startDate: Date? = nil
        public var abbrevName: String = ""
        public var name: String = ""
        @Relationship(deleteRule: .cascade) public var games: [Game] = []
        var site: Site? = nil
        @Relationship(deleteRule: .cascade, inverse: \Team.season) public var teams: [Team] = []
        
        public init() { }
    }
    
    @Model final public class Site {
        var siteId: Int32 = 0
        var name: String = ""
        @Relationship(inverse: \User.sites) public var users: [User] = []
        @Relationship(deleteRule: .cascade) public var seasons: [Season] = []
        @Relationship(deleteRule: .cascade) public var leagues: [League] = []
        @Relationship(inverse: \Team.site) public var teams: [Team] = []
        
        public init() { }
    }
    
    @Model final public class SubEvent {
        public var eventTime: Int16 = 0
        public var eventPeriod: Int16 = 0
        public var player5: Player? = nil
        public var player4: Player? = nil
        public var player3: Player? = nil
        public var event: Event
        public var player1: Player? = nil
        public var player2: Player? = nil
        
        public init(event: Event) {
            self.event = event
        }
    }
    
    @Model final public class Team {
        public var abbrevName: String = ""
        var trackSubs: Bool = false
        public var awayColorIndex: Int16 = 0
        var idLarge: String = ""
        var rosterId: Int32 = 0
        var primaryColor: String = ""
        public var homeColorIndex: Int16 = 0
        var tempUseAltJersey: Bool = false
        public var name: String = ""
        var coach: String = ""
        var gender: Int16 = 0
        var idCode: String = ""
        var isFavorite: Bool = false
        var defaultShotsMade: Bool = false
        var teamId: Int32? = 0
        var dataImportType: Int32 = 0
        var secondaryColor: String = ""
        var hiddenFlag: Bool = false
        @Relationship(deleteRule: .cascade) public var players: [Player] = []
        @Relationship(deleteRule: .cascade) public var image: Image? = nil
        @Relationship(deleteRule: .cascade) public var gameStatObjects: [GameStatObject] = []
        var site: Site? = nil
        @Relationship(deleteRule: .cascade) public var events: [Event] = []
        var division: Division? = nil
        @Relationship(deleteRule: .cascade) public var gameTeamInfo: [GameTeamInfo] = []
        @Relationship(deleteRule: .cascade) public var emailStatMachine: EMail? = nil
        @Relationship(deleteRule: .cascade) public var email: EMail? = nil
        public var league: League? = nil
        @Relationship(deleteRule: .cascade) public var emailMaxPreps: EMail? = nil
        var season: Season? = nil
        @Relationship(inverse: \User.teams) public var users: [User] = []
        @Relationship(deleteRule: .cascade) public var logo: Logo? = nil
        
        public init() { }
    }
    
    @Model final public class TimeEvent {
        public var eventTime: Int16 = 0
        @Attribute(originalName: "type") var timeEventType: Int16 = 0
        var comment: String = ""
        var eventPeriod: Int16 = 0
        public var event: Event
        
        public init(event: Event) {
            self.event = event
        }
    }
    
    @Model final public class Tournament {
        var startDate: Date? = nil
        var name: String = ""
        var idLarge: String = ""
        var game: [Game] = []
        
        public init() { }
    }
    
    @Model final public class User {
        var userId: Int32 = 0
        var firstName: String = ""
        var userName: String = ""
        var lastName: String = ""
        var teams: [Team] = []
        var leagues: [League] = []
        @Relationship(deleteRule: .cascade) public var sites: [Site] = []
        
        public init() { }
    }
    
    @Model final public class Version {
        var model: Int16 = 1
        var apptype: String? = nil
        
        public init() { }
    }
    
    @Model final public class WeightSystem {
        public var id: Int16 = 0
        var timeDivide: Bool = false
        var locked: Bool = false
        var name: String = ""
        var localizedName: String = ""
        @Relationship(deleteRule: .cascade, inverse: \WeightSystemEntry.weightSystem) public var weightSystemEntry: [WeightSystemEntry] = []
        
        public init() { }
    }
    
    @Model final public class WeightSystemEntry {
        var defaultValue: Float = 0
        var weightValue: Float = 0
        var weightSystem: WeightSystem? = nil
        var weightType: WeightType? = nil
        
        public init() { }
    }
    
    @Model final public class WeightType {
        public var id: Int16 = 0
        var groupID: Int16 = 0
        var name: String = ""
        var localizedName: String = ""
        @Relationship(deleteRule: .cascade) public var weightSystemEntry: [WeightSystemEntry]?
        var eventType: EventTypes? = nil
        
        public init() { }
    }
}
