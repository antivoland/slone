/**
 * @author antivoland
 */
package ru.antimiaou.slone.extractor.model.edge;

import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import ru.antimiaou.slone.extractor.model.edge.handler.*;

public enum KvesterEdgeType {
    M(new MKvesterEdgeHandler()), // Действие
    I(new IKvesterEdgeHandler()), // Условия
    C(new CKvesterEdgeHandler()), // Проверить
    R(new RKvesterEdgeHandler()), // Случайно
    T(new TKvesterEdgeHandler()); // Счетчик

    private final KvesterEdgeHandler handler;

    private KvesterEdgeType(KvesterEdgeHandler handler) {
        this.handler = handler;
    }

    public KvesterEdge retrieveEdge(String parentId, Document parentDoc) {
        KvesterEdge edge = handler.retrieveEdge(parentId, parentDoc);
        edge.setType(this);

        String nameSel = "links[" + parentId + "][name]";
        Element name = parentDoc.getElementsByAttributeValue("name", nameSel).first();
        edge.setName(name.attr("value"));
        return edge;
    }
}
