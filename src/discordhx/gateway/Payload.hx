package discordhx.gateway;
import discordhx.gateway.events.GatewayEventTypes;
import crossbyte.Object;
import discordhx.gateway.op.Opcode;

/**
 * ...
 * @author Christopher Speciale
 */
/**
 * Represents a generic payload structure for Discord Gateway opcodes.
 * @tparam T The type of the data contained in the payload.
 */
abstract Payload<T>(IPayload) from Object to Object {
    public var sequence(get, set):Null<Int>;
    public var opcode(get, set):Opcode;
    public var data(get, set):T;
    public var type(get, set):Null<GatewayEventTypes>;

    public function new() {
        this = cast {
            "d": null,
            "op": null,
            "s": null,
            "t": null
        };
    }

    private function get_sequence():Null<Int> {
        return this.s;
    }

    private function set_sequence(value:Null<Int>):Null<Int> {
        return this.s = value;
    }

    private function get_opcode():Opcode {
        return this.op;
    }

    private function set_opcode(value:Opcode):Opcode{
        return this.op = value;
    }

    private function get_data():T {
        return this.d;
    }

    private function set_data(value:T):T {
        return this.d = value;
    }

    private function get_type():Null<String> {
        return this.t;
    }

    private function set_type(value:Null<String>):Null<String> {
        return this.t = value;
    }
}

@:noCompletion private interface IPayload {
    public var s:Null<Int>;
    public var op:Int;
    public var d:Dynamic;
    public var t:Null<String>;
}