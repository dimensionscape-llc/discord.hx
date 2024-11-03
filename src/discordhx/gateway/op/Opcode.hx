package discordhx.gateway.op;

/**
 * @author Christopher Speciale
 */

enum abstract Opcode(Int) from Int to Int {
    var DISPATCH:Int = 0;
    var HEARTBEAT:Int = 1;
    var IDENTIFY:Int = 2;
    var PRESENCE_UPDATE:Int = 3;
    var VOICE_STATE_UPDATE:Int = 4;
    var RESUME:Int = 6;
    var RECONNECT:Int = 7;
    var REQUEST_GUILD_MEMBERS:Int = 8;
    var INVALID_SESSION:Int = 9;
    var HELLO:Int = 10;
    var HEARTBEAT_ACK:Int = 11;
}