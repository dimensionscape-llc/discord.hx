package discordhx.config;

/**
 * @author Christopher Speciale
 */
enum abstract Intents(Int) from Int to Int {
    var GUILDS:Int = 1 << 0;
    var GUILD_MEMBERS:Int = 1 << 1;
    var GUILD_BANS:Int = 1 << 2;
    var GUILD_EMOJIS:Int = 1 << 3;
    var GUILD_INTEGRATIONS:Int = 1 << 4;
    var GUILD_WEBHOOKS:Int = 1 << 5;
    var GUILD_INVITES:Int = 1 << 6;
    var GUILD_VOICE_STATES:Int = 1 << 7;
    var GUILD_PRESENCES:Int = 1 << 8;
    var GUILD_MESSAGES:Int = 1 << 9;
    var GUILD_MESSAGE_REACTIONS:Int = 1 << 10;
    var GUILD_MESSAGE_TYPING:Int = 1 << 11;
    var DIRECT_MESSAGES:Int = 1 << 12;
    var DIRECT_MESSAGE_REACTIONS:Int = 1 << 13;
    var DIRECT_MESSAGE_TYPING:Int = 1 << 14;
    var MESSAGE_CONTENT:Int = 1 << 15;
}