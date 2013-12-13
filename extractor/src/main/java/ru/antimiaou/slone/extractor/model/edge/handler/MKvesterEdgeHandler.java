/**
 * @author antivoland
 */
package ru.antimiaou.slone.extractor.model.edge.handler;

import org.jsoup.nodes.Document;
import ru.antimiaou.slone.extractor.model.edge.KvesterEdge;
import ru.antimiaou.slone.extractor.model.edge.MKvesterEdge;

public class MKvesterEdgeHandler extends KvesterEdgeHandler {
    @Override
    public KvesterEdge retrieveEdge(String parentId, Document parentDoc) {
        MKvesterEdge edge = new MKvesterEdge();
        edge.setAction(retrieveAction(parentId, parentDoc, 0));
        return edge;
    }

}
