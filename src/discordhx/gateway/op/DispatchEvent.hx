package discordhx.gateway.op;

import crossbyte.Object;

abstract DispatchEvent<T>(Object) from Object to Object{
    public var event(get, set):T;

    private inline function get_event():T{
        return (this:T);
    }

    private inline function set_event(value:T):T{
        return this = value;
    }
}