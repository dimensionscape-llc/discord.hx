package discordhx.utils;


enum abstract UserFlags(Int) from Int to Int {
    var NONE = 0;
    var DISCORD_EMPLOYEE = 1 << 0;
    var PARTNERED_SERVER_OWNER = 1 << 1;
    var HYPESQUAD_EVENTS = 1 << 2;
    var BUG_HUNTER_LEVEL_1 = 1 << 3;
    var HOUSE_BRAVERY = 1 << 6;
    var HOUSE_BRILLIANCE = 1 << 7;
    var HOUSE_BALANCE = 1 << 8;
    var EARLY_SUPPORTER = 1 << 9;
    var TEAM_USER = 1 << 10;
    var BUG_HUNTER_LEVEL_2 = 1 << 14;
    var VERIFIED_BOT = 1 << 16;
    var VERIFIED_DEVELOPER = 1 << 17;
    var CERTIFIED_MODERATOR = 1 << 18;
    var BOT_HTTP_INTERACTIONS = 1 << 19;
}