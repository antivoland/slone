/**
 * @author antivoland
 */
package ru.antimiaou.slone.extractor.model.action;

import org.jsoup.nodes.Document;
import ru.antimiaou.slone.extractor.model.action.handler.KvesterActionHandler;
import ru.antimiaou.slone.extractor.model.action.handler.MKvesterActionHandler;
import ru.antimiaou.slone.extractor.model.action.handler.TKvesterActionHandler;

public enum KvesterActionType {
    M(new MKvesterActionHandler()), // Переход
    T(new TKvesterActionHandler()); // Сообщение

    private final KvesterActionHandler handler;

    private KvesterActionType(KvesterActionHandler handler) {
        this.handler = handler;
    }

    public KvesterAction retrieveAction(String parentId, Document parentDoc, int actionIndex) {
        return handler.retrieveAction(parentId, parentDoc, actionIndex);
    }
}
