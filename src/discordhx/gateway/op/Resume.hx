package discordhx.gateway.op;
import crossbyte.Object;

abstract Resume(IResume) from Object to Object {
    public var token(get, set): String;
    public var sessionID(get, set): String;
    public var sequence(get, set): Int;

    public inline function new(value: IResume) {
        this = value;
    }

    private function get_token(): String {
        return this.token;
    }

    private function set_token(value: String): String {
        return this.token = value;
    }

    private function get_sessionID(): String {
        return this.session_id;
    }

    private function set_sessionID(value: String): String {
        return this.session_id = value;
    }

    private function get_sequence(): Int {
        return this.seq;
    }

    private function set_sequence(value: Int): Int {
        return this.seq = value;
    }
}

@:noCompletion private interface IResume {
    public var token: String;
    public var session_id: String;
    public var seq: Int;
}