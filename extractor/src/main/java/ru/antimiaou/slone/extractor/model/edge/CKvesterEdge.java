/*
 * @author antivoland
 */
package ru.antimiaou.slone.extractor.model.edge;

import ru.antimiaou.slone.extractor.model.action.KvesterAction;

import java.util.Set;

public class CKvesterEdge extends KvesterEdge {
    private Set<String> conditions;
    private KvesterAction successAction;
    private KvesterAction failAction;

    public Set<String> getConditions() {
        return conditions;
    }

    public void setConditions(Set<String> conditions) {
        this.conditions = conditions;
    }

    public KvesterAction getSuccessAction() {
        return successAction;
    }

    public void setSuccessAction(KvesterAction successAction) {
        this.successAction = successAction;
    }

    public KvesterAction getFailAction() {
        return failAction;
    }

    public void setFailAction(KvesterAction failAction) {
        this.failAction = failAction;
    }
}
