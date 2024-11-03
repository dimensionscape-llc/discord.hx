package discordhx.gateway.events;

import discordhx.entities.Guild;
import discordhx.entities.User;
import crossbyte.Object;
import crossbyte.url.URL;

abstract Ready(Object) from Object to Object{
    public var version(get, never):Int;
    public var user(get, never):User;
    public var guilds(get, never):Array<Guild>;
    public var sessionID(get, never):String;
    public var resumeGatewayURL(get, never):URL;
    public var shard(get, never):Array<Int>;
    public var application(get, never):Dynamic;

    private inline function get_version():Int{
        return this.v;
    }

    private inline function get_user():User{
        return this.user;
    }

    private inline function get_guilds():Array<Guild>{
        return this.guilds;
    }

    private inline function get_sessionID():String{
        return this.session_id;
    }

    private inline function get_resumeGatewayURL():URL{
        return this.resume_gateway_url;
    }

    private inline function get_shard():Array<Int>{
        return this.shard;
    }

    private inline function get_application():Dynamic{
        return this.application;
    }
}

@:noCompletion private interface IReady{
   // v	integer	API version
   // user	user object	Information about the user including email
   // guilds	array of Unavailable Guild objects	Guilds the user is in
   // session_id	string	Used for resuming connections
   // resume_gateway_url	string	Gateway URL for resuming connections
   // shard?	array of two integers (shard_id, num_shards)	Shard information associated with this session, if sent when identifying
    //application

    public var v:Int;
    public var user:Dynamic;
    public var guilds:Array<Dynamic>;
    public var session_id:String;
    public var resume_gateway_url:String;
    public var shard:Array<Int>;
    public var application:Dynamic;
}