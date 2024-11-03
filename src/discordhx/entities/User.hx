package discordhx.entities;

import discordhx.utils.UserFlags;
import crossbyte.Object;
import discordhx.utils.Snowflake;

abstract User(Object) from Object to Object {
    public inline function new(data: Object) {
        this = data;
    }

    public var id(get, never): Snowflake;
    public var username(get, never): String;
    public var discriminator(get, never): String;
    public var global_name(get, never): Null<String>;
    public var avatar(get, never): Null<String>;
    public var bot(get, never): Bool;
    public var system(get, never): Bool;
    public var mfa_enabled(get, never): Bool;
    public var banner(get, never): Null<String>;
    public var accent_color(get, never): Null<Int>;
    public var locale(get, never): Null<String>;
    public var verified(get, never): Null<Bool>;
    public var email(get, never): Null<String>;
    public var flags(get, never): UserFlags;
    public var premium_type(get, never): Null<Int>;
    public var public_flags(get, never): UserFlags;
    public var avatar_decoration_data(get, never): Null<Dynamic>;

    inline function get_id(): Snowflake {
        return new Snowflake(this.id);
    }

    inline function get_username(): String {
        return this.username;
    }

    inline function get_discriminator(): String {
        return this.discriminator;
    }

    inline function get_global_name(): Null<String> {
        return this.global_name;
    }

    inline function get_avatar(): Null<String> {
        return this.avatar;
    }

    inline function get_bot(): Bool {
        return this.bot;
    }

    inline function get_system(): Bool {
        return this.system;
    }

    inline function get_mfa_enabled(): Bool {
        return this.mfa_enabled;
    }

    inline function get_banner(): Null<String> {
        return this.banner;
    }

    inline function get_accent_color(): Null<Int> {
        return this.accent_color;
    }

    inline function get_locale(): Null<String> {
        return this.locale;
    }

    inline function get_verified(): Null<Bool> {
        return this.verified;
    }

    inline function get_email(): Null<String> {
        return this.email;
    }

    inline function get_flags(): UserFlags {
        return this.flags;
    }

    inline function get_premium_type(): Null<Int> {
        return this.premium_type;
    }

    inline function get_public_flags(): UserFlags {
        return this.public_flags;
    }

    inline function get_avatar_decoration_data(): Null<Dynamic> {
        return this.avatar_decoration_data;
    }
}