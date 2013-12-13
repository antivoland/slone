/**
 * @author antivoland
 */
package ru.antimiaou.slone.extractor.model.action.handler;

import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import ru.antimiaou.slone.extractor.model.action.KvesterAction;
import ru.antimiaou.slone.extractor.model.action.TKvesterAction;

public class TKvesterActionHandler implements KvesterActionHandler {
    @Override
    public KvesterAction retrieveAction(String parentId, Document parentDoc, int actionIndex) {
        TKvesterAction action = new TKvesterAction();

        String messageSel = "action[" + parentId + "][" + actionIndex + "][message]";
        Element message = parentDoc.getElementsByAttributeValue("name", messageSel).first();
        action.setMessage(message.text());

        String hideSel = "action[" + parentId + "][" + actionIndex + "][hide]";
        Element hide = parentDoc.getElementsByAttributeValue("name", hideSel).first();
        action.setHide("checked".equals(hide.attr("checked")));

        return action;
    }
}
