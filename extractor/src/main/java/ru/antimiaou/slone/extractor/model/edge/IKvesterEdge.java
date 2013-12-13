/*
 * @author antivoland
 */
package ru.antimiaou.slone.extractor.model.edge;

import ru.antimiaou.slone.extractor.model.action.KvesterAction;

import java.util.Set;

public class IKvesterEdge extends KvesterEdge {
    private Set<String> addInventories;
    private Set<String> subInventories;
    private KvesterAction action;

    public Set<String> getAddInventories() {
        return addInventories;
    }

    public void setAddInventories(Set<String> addInventories) {
        this.addInventories = addInventories;
    }

    public Set<String> getSubInventories() {
        return subInventories;
    }

    public void setSubInventories(Set<String> subInventories) {
        this.subInventories = subInventories;
    }

    public KvesterAction getAction() {
        return action;
    }

    public void setAction(KvesterAction action) {
        this.action = action;
    }
}
