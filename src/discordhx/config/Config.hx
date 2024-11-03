package discordhx.config;
import crossbyte.url.URL;

/**
 * ...
 * @author Christopher Speciale
 */
class Config 
{
	public var token:String;
	public var url:String;
	public var intents:Int;
	
	public function new(token:String, url:URL, intents:Int) 
	{
		this.token = token;
		this.url = url;
		this.intents = intents;
	}
	
}