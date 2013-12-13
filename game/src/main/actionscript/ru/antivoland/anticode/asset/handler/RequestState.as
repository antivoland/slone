/*
 * @author antivoland
 */
package ru.antivoland.anticode.asset.handler {
internal class RequestState {
    public static const WAITING:RequestState = new RequestState("WAITING");
    public static const LOADING:RequestState = new RequestState("LOADING");
    public static const READY:RequestState = new RequestState("READY");
    public static const ERROR:RequestState = new RequestState("ERROR");

    private var name:String;

    public function RequestState(name:String) {
        this.name = name;
    }
}
}