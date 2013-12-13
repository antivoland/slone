/**
 * @author antivoland
 */
package ru.antimiaou.slone.extractor.model.edge.handler;

import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import ru.antimiaou.slone.extractor.model.action.KvesterAction;
import ru.antimiaou.slone.extractor.model.action.KvesterActionType;
import ru.antimiaou.slone.extractor.model.edge.KvesterEdge;

public abstract class KvesterEdgeHandler {
    public abstract KvesterEdge retrieveEdge(String parentId, Document parentDoc);

    public KvesterAction retrieveAction(String parentId, Document parentDoc, int actionIndex) {
        KvesterActionType type = retrieveActionType(parentId, parentDoc, actionIndex);
        KvesterAction action = type.retrieveAction(parentId, parentDoc, actionIndex);
        action.setType(type);
        return action;
    }

    public KvesterActionType retrieveActionType(String parentId, Document parentDoc, int actionIndex) {
        String typeSel = "action[" + parentId + "][" + actionIndex + "][type]";
        Element type = parentDoc.getElementsByAttributeValue("name", typeSel).first()
                .getElementsByAttributeValue("selected", "selected").first();
        return KvesterActionType.valueOf(type.attr("value"));
    }
}
