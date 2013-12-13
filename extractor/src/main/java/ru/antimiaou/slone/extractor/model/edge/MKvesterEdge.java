/*
 * @author antivoland
 */
package ru.antimiaou.slone.extractor.model.edge;

import ru.antimiaou.slone.extractor.model.action.KvesterAction;

public class MKvesterEdge extends KvesterEdge {
    private KvesterAction action;

    public KvesterAction getAction() {
        return action;
    }

    public void setAction(KvesterAction action) {
        this.action = action;
    }
}
