package discordhx.discord;
import sys.Http;
import crossbyte.url.URLRequest;
import crossbyte.url.URLRequestHeader;
import crossbyte.url.URLLoader;
import crossbyte.events.HTTPStatusEvent;
import crossbyte.events.IOErrorEvent;
import crossbyte.events.Event;
import discordhx.gateway.Payload;
import emitter.signals.Emitter;
import discordhx.gateway.Gateway;
import discordhx.config.Config;
import haxe.Json;

/**
 * ...
 * @author Christopher Speciale
 */
@:access(discordhx.gateway.Gateway)
class Client extends Emitter
{

	public var config(default, null):Config;
	public var gateway(default, null):Gateway;
	
	public function new(config:Config) 
	{
		super();
		this.config = config;
		_init();
	}
	
	private function _init():Void{
		gateway = new Gateway(config.token, config.url, config.intents);
	}

	public function sendMessage(channelId: String, content: String): Void {
        var url = "https://discord.com/api/v10/channels/" + channelId + "/messages";
        var payload = {
            content: content
        };

        var http = new Http(url);
        http.setHeader("Content-Type", "application/json");
        http.setHeader("Authorization", "Bot " + config.token);        
        http.setPostData(Json.stringify(payload));
		http.request(true);
    }
} 