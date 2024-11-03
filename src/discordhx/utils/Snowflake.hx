package discordhx.utils;

abstract Snowflake(String) from String to String {
    public static inline var DISCORD_EPOCH = 1420070400000;

    public inline function new(value: String){
        this = value;
    }

    public inline function toString(): String {
        return this;
    }

    public function getTimestamp(): Float {
        var snowflakeInt: Float = Std.parseFloat(this);
        return Math.floor(snowflakeInt / 4194304) + DISCORD_EPOCH;
    }

    public function getWorkerId(): Int {
        var snowflakeInt: Float = Std.parseFloat(this);
        return (Std.int(snowflakeInt / 1024) % 32);
    }

    public function getProcessId(): Int {
        var snowflakeInt: Float = Std.parseFloat(this);
        return (Std.int(snowflakeInt / 32) % 32);
    }

    public function getIncrement(): Int {
        var snowflakeInt: Float = Std.parseFloat(this);
        return Std.int(snowflakeInt % 4096);
    }
}