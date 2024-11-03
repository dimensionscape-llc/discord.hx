package discordhx.gateway;

import discordhx.gateway.op.Resume;
import discordhx.gateway.events.Ready;
import discordhx.gateway.op.Heartbeat;
import crossbyte.utils.Timer;
import haxe.display.JsonModuleTypes.JsonTConstantKind;
import discordhx.gateway.op.IIdentify;
import crossbyte.Object;
import crossbyte.events.Event;
import crossbyte.events.EventDispatcher;
import crossbyte.events.HTTPStatusEvent;
import crossbyte.events.IOErrorEvent;
import crossbyte.events.ProgressEvent;
import crossbyte.net.WebSocket;
import crossbyte.url.URL;
import crossbyte.url.URLLoader;
import crossbyte.url.URLRequest;
import crossbyte.url.URLRequestHeader;
import discordhx.gateway.op.IHello;
import discordhx.gateway.op.Opcode;
import emitter.signals.Emitter;
import haxe.Json;
import crossbyte.sys.System;
import discordhx.gateway.op.DispatchEvent;
import discordhx.gateway.events.MessageCreate;
import discordhx.entities.Message;
/**
 * ...
 * @author Christopher Speciale
 */
class Gateway extends Emitter {
	private static inline var PORT:Int = 443;

	public var url:String;
	public var token:String;
	public var sessionID:String;
	public var sequenceNumber:Null<Int>;

	private var _wssAddress:URL;
	private var _intents:Int;
	private var _shards:Null<Int>;
	private var _shardID:Int;
	private var _ws:WebSocket;
	private var _url:URL;
	private var _heartbeatInterval:Int;
	private var _trace:Array<String>;
	private var _heartbeatTimerID:UInt;
	private var _resumeGatewayURL:URL;

	// Make the constructor private
	@:noCompletion private function new(token:String, url:URL, ?intents:Int, ?shards:Int, ?shardID:Int) {
		super();
		this.token = token;
		this._url = url;
		this._intents = intents;

		_setupWebsocketClient();
	}

	private function _gatewayAuthorization():Void {
		var httpLoader = new URLLoader();
		var httpRequest:URLRequest = new URLRequest();
		var header:URLRequestHeader;
		httpRequest.method = "GET";

		if (token != null) {
			header = new URLRequestHeader("Authorization", "Bot" + " " + token);
			httpRequest.requestHeaders.push(header);
			httpRequest.url = _url;
		}

		httpLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
		httpLoader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, httpResponseStatusHandler);
		httpLoader.addEventListener(Event.COMPLETE, _onGatewayAuthorization);

		httpLoader.load(httpRequest);
	}

	private function httpStatusHandler(event:HTTPStatusEvent):Void {
		Sys.println("httpStatusHandler: " + event);
		Sys.println("status: " + event.status);
	}

	private function httpResponseStatusHandler(event:HTTPStatusEvent):Void {
		Sys.println("httpResponseStatusHandler: " + event);
		Sys.println("status: " + event.status);

		for (object in event.responseHeaders) {
			Sys.println(object.name + " : " + object.value);
		}
	}

	private function _onGatewayAuthorization(event:Event):Void {
		Sys.println("Gateway Authorization Response");
		var urlLoader:URLLoader = event.target;
		var responseObj:Object = Json.parse(urlLoader.data);

		_wssAddress = responseObj.url;
		_shards = responseObj.shards;

		trace(responseObj.url, _wssAddress);
		if (_wssAddress == null) {
			Sys.println("ERROR: Connection failed. Try Again.");
		} else {
			_openWSConnection();
		}
	}

	private function _openWSConnection():Void {
		var wsURL = _resumeGatewayURL != null ? _resumeGatewayURL : _wssAddress;
		_ws.connect(wsURL, PORT);
	}

	private function _setupWebsocketClient():Void {
		_ws = new WebSocket();
		_ws.secure = true;
		_ws.addEventListener(ProgressEvent.SOCKET_DATA, _onData);
		_ws.addEventListener(Event.CONNECT, _onConnect);
		_ws.addEventListener(IOErrorEvent.IO_ERROR, _onError);
		_ws.addEventListener(Event.CLOSE, _onClose);
	}

	private function _onData(e:ProgressEvent):Void {
		trace("ONDATA");
		var payloadData:String = _ws.readUTFBytes(_ws.bytesAvailable);
		trace(payloadData);
		var dynamicPayload:Payload<Dynamic> = Json.parse(payloadData);

		trace(dynamicPayload.sequence, sequenceNumber);
		switch (dynamicPayload.opcode) {
			case DISPATCH:
				sequenceNumber = dynamicPayload.sequence;
				_onDispatch(dynamicPayload);
				trace("onDispatch");
			// ;
			case HEARTBEAT:
				trace("onHeartbeat");
			// ;
			case IDENTIFY:
				trace("onIdentify");
			// ;
			case PRESENCE_UPDATE:
				trace("onPresenceUpdate");
			// ;
			case VOICE_STATE_UPDATE:
				trace("onVoiceStateUpdate");
			// ;
			case RESUME:
				trace("onResume");
			// ;
			case RECONNECT:
				trace("onReconnect");
			// ;
			case REQUEST_GUILD_MEMBERS:
				trace("onRequestGuildMembers");
			// ;
			case INVALID_SESSION:
				trace("onInvalidSession");
				_onInvalidSession(dynamicPayload);
			// ;
			case HELLO:
				trace("onHello");
				_onHello(dynamicPayload);
			case HEARTBEAT_ACK:
				trace("onHeartbeakAck");
				// ;
		}
	}

	private function _onDispatch(payload:Payload<DispatchEvent<Dynamic>>) {
		trace("EVENT TYPE:", payload.type);
		switch (payload.type) {
			case READY:
				_onReadyEvent(payload.data.event);
			case RESUMED:
				trace("on resumed");
			case MESSAGE_CREATE:
				_onMessageCreateEvent(payload.data.event);
			default:
		}
	}

	private function _onReadyEvent(event:Ready):Void {
		trace("Guilds:", event.guilds);
		trace("User:", event.user);
		trace("SessionID:", event.sessionID);
		trace("Application:", event.application);
		this.sessionID = event.sessionID;
		this._resumeGatewayURL = event.resumeGatewayURL;

		emit("READY", event);
	}
	
	private function _onMessageCreateEvent(event:MessageCreate<Message>):Void{
		trace(event.message.content);
		
		emit("messageCreate", event);

		//_parseMessage(event.message);
	}


	

	private function _onInvalidSession(payload:Payload<Dynamic>):Void {
		var canResume:Bool = payload.data; // `true` if the session can be resumed, `false` otherwise
		if (canResume) {
			_attemptResume();
		} else {
			_resumeGatewayURL = null;
			_openWSConnection();
		}
	}

	private function _onHello(payload:Payload<IHello>):Void {
		_heartbeatInterval = payload.data.heartbeat_interval;
		_trace = payload.data._trace;

		var jitter:Float = Math.random();
		var firstWaitTime:Int = Math.floor(_heartbeatInterval * jitter);
		_heartbeatTimerID = Timer.setTimeout(_setupHeartbeat, firstWaitTime);

		if (sessionID != null) {
			_attemptResume();
		} else {
			_identify();
		}
	}

	private function _identify():Void {
		var payload:Payload<IIdentify> = new Payload();
		payload.opcode = IDENTIFY;

		var identify:IIdentify = new Object();
		identify.compress = false;
		identify.intents = _intents;
		identify.token = token;

		if (_shards > 1) {
			identify.shard = [_shardID, _shards];
		}

		identify.compress = false;
		payload.data = identify;

		var identity:Identity = new Object();
		identity.browser = "haxe";
		identity.os = System.PLATFORM;
		identity.device = "haxe";

		payload.data.properties = identity;

		send(payload);
	}

	private function _setupHeartbeat():Void {
		_sendHeartbeat();
		_heartbeatTimerID = Timer.setInterval(_sendHeartbeat, _heartbeatInterval);
	}

	private function _sendHeartbeat():Void {
		trace(sequenceNumber);
		var payload:Payload<Heartbeat> = new Payload();
		payload.data = sequenceNumber;
		payload.opcode = HEARTBEAT;
		trace(Json.stringify(payload));
		send(payload);
	}

	private function _attemptResume():Void {
		if (sessionID != null && sequenceNumber != null) {
			trace('Attempting to resume session...');
			var payload:Payload<Resume> = new Payload();
			payload.opcode = RESUME;
			payload.data.token = token;
			payload.data.sequence = sequenceNumber;
			payload.data.sessionID = sessionID;

			send(payload);
		} else {
			trace('No session to resume, reconnecting...');
			_openWSConnection();
		}
	}

	private function _onConnect(e:Event):Void {
		trace('connect');
	}

	private function _onError(e:IOErrorEvent):Void {
		trace('error');
	}

	private function _onClose(e:Event):Void {
		Timer.clearInterval(_heartbeatTimerID);
		trace('close');
	}

	public function connect():Void {
		_gatewayAuthorization();
	}

	public function disconnect():Void {
		// Disconnect from the gateway
	}

	public function send(payload:Payload<Any>):Void {
		var data:String = Json.stringify(payload);
		// Send data through the WebSocket
		_ws.writeUTFBytes(data);
		_ws.flush();
		trace('send');
	}

	private function handleMessage(event:String, data:Dynamic):Void {
		// Handle incoming WebSocket messages
		this.emit(event, data);
	}
}
