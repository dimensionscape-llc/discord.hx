package discordhx.gateway.op;

abstract Heartbeat(Null<Int>) from Null<Int> to Null<Int>{
    public inline function new(value:Null<Int>){
        this = value;
    }
}