package discordhx.entities;

import discordhx.utils.Snowflake;

abstract Guild(Dynamic) {
    public inline function new(data: Dynamic) {
        this = data;
    }

    public var id(get, never): Snowflake;
    public var name(get, never): String;
    public var owner_id(get, never): String;
    public var roles(get, never): Array<Dynamic>;
    public var channels(get, never): Array<Dynamic>;
    public var members(get, never): Array<Dynamic>;
    public var emojis(get, never): Array<Dynamic>;
    public var unavailable(get, never): Bool;

    inline function get_id(): Snowflake {
        return this.id;
    }

    inline function get_name(): String {
        return this.name;
    }

    inline function get_owner_id(): String {
        return this.owner_id;
    }

    inline function get_roles(): Array<Dynamic> {
        return this.roles;
    }

    inline function get_channels(): Array<Dynamic> {
        return this.channels;
    }

    inline function get_members(): Array<Dynamic> {
        return this.members;
    }

    inline function get_emojis(): Array<Dynamic> {
        return this.emojis;
    }

    inline function get_unavailable(): Bool {
        return this.unavailable;
    }
}