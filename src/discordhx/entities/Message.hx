package discordhx.entities;

import crossbyte.Object;
import discordhx.gateway.events.MessageCreate;
import discordhx.utils.Snowflake;


abstract Message(Object) {
    private inline function new(data: Object) {
        this = data;
    }

    public var id(get, never): Snowflake;
    public var channel_id(get, never): Snowflake;
    public var guild_id(get, never): Null<Snowflake>;
    public var author(get, never): Dynamic; // You can replace this with a User entity if you have one
    public var member(get, never): Null<Dynamic>; // Guild member data
    public var content(get, never): String;
    public var timestamp(get, never): String;
    public var edited_timestamp(get, never): Null<String>;
    public var tts(get, never): Bool;
    public var mention_everyone(get, never): Bool;
    public var mentions(get, never): Array<User>; 
    public var mention_roles(get, never): Array<Snowflake>;
    public var mention_channels(get, never): Null<Array<Dynamic>>; // Channels mentioned in this message
    public var attachments(get, never): Array<Dynamic>; // Message attachments
    public var embeds(get, never): Array<Dynamic>; // Embedded content
    public var reactions(get, never): Null<Array<Dynamic>>; // Reactions to the message
    public var nonce(get, never): Null<Dynamic>; // Used for validating messages sent by the client
    public var pinned(get, never): Bool;
    public var webhook_id(get, never): Null<Snowflake>;
    public var type(get, never): Int;
    public var activity(get, never): Null<Dynamic>; // Message activity data
    public var application(get, never): Null<Dynamic>; // Message application data
    public var message_reference(get, never): Null<Dynamic>; // Reference to the original message
    public var flags(get, never): Null<Int>;

    inline function get_id(): Snowflake {
        return new Snowflake(this.id);
    }

    inline function get_channel_id(): Snowflake {
        return new Snowflake(this.channel_id);
    }

    inline function get_guild_id(): Null<Snowflake> {
        return this.guild_id != null ? new Snowflake(this.guild_id) : null;
    }

    inline function get_author(): Dynamic {
        return this.author;
    }

    inline function get_member(): Null<Dynamic> {
        return this.member;
    }

    inline function get_content(): String {
        return this.content;
    }

    inline function get_timestamp(): String {
        return this.timestamp;
    }

    inline function get_edited_timestamp(): Null<String> {
        return this.edited_timestamp;
    }

    inline function get_tts(): Bool {
        return this.tts;
    }

    inline function get_mention_everyone(): Bool {
        return this.mention_everyone;
    }

    inline function get_mentions(): Array<Dynamic> {
        return this.mentions;
    }

    inline function get_mention_roles(): Array<Snowflake> {
        return this.mention_roles;
    }

    inline function get_mention_channels(): Null<Array<Dynamic>> {
        return this.mention_channels;
    }

    inline function get_attachments(): Array<Dynamic> {
        return this.attachments;
    }

    inline function get_embeds(): Array<Dynamic> {
        return this.embeds;
    }

    inline function get_reactions(): Null<Array<Dynamic>> {
        return this.reactions;
    }

    inline function get_nonce(): Null<Dynamic> {
        return this.nonce;
    }

    inline function get_pinned(): Bool {
        return this.pinned;
    }

    inline function get_webhook_id(): Null<Snowflake> {
        return this.webhook_id != null ? new Snowflake(this.webhook_id) : null;
    }

    inline function get_type(): Int {
        return this.type;
    }

    inline function get_activity(): Null<Dynamic> {
        return this.activity;
    }

    inline function get_application(): Null<Dynamic> {
        return this.application;
    }

    inline function get_message_reference(): Null<Dynamic> {
        return this.message_reference;
    }

    inline function get_flags(): Null<Int> {
        return this.flags;
    }
}