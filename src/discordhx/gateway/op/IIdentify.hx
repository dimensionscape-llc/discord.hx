package discordhx.gateway.op;

interface IIdentify {
   public var compress:Bool;
   public var token: String;
   public var intents: Int;
   public var large_threshold:Null<Int>;
   public var presence: Dynamic;
   public var properties: Identity;
   public var shard: Null<Array<Int>>;
}

interface Identity{
    public var os:String;
    public var browser:String;
    public var device:String;
}