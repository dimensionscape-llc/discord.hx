package discordhx.gateway.events;

import discordhx.entities.User;
import discordhx.utils.Snowflake;
import crossbyte.Object;

abstract MessageCreate<T>(Object){
    public var message(get, never):T;

    private function get_message():T{
        return (this:T);
    }
}
