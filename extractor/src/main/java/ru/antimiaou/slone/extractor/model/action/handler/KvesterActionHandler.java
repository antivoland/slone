/**
 * @author antivoland
 */
package ru.antimiaou.slone.extractor.model.action.handler;

import org.jsoup.nodes.Document;
import ru.antimiaou.slone.extractor.model.action.KvesterAction;

public interface KvesterActionHandler {
    KvesterAction retrieveAction(String parentId, Document parentDoc, int actionIndex);
}
