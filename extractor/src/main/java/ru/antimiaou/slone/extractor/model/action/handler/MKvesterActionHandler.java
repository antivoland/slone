/**
 * @author antivoland
 */
package ru.antimiaou.slone.extractor.model.action.handler;

import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import ru.antimiaou.slone.extractor.model.action.KvesterAction;
import ru.antimiaou.slone.extractor.model.action.MKvesterAction;

public class MKvesterActionHandler implements KvesterActionHandler {
    @Override
    public KvesterAction retrieveAction(String parentId, Document parentDoc, int actionIndex) {
        MKvesterAction action = new MKvesterAction();

        String nodeToSel = "action[" + parentId + "][" + actionIndex + "][id_point]";
        Element nodeTo = parentDoc.getElementsByAttributeValue("name", nodeToSel).first()
                .getElementsByAttributeValue("selected", "selected").first();
        action.setNodeTo(nodeTo.attr("value"));

        return action;
    }
}
