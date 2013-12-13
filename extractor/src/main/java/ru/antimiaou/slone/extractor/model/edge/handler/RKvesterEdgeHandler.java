/**
 * @author antivoland
 */
package ru.antimiaou.slone.extractor.model.edge.handler;

import org.jsoup.nodes.Document;
import ru.antimiaou.slone.extractor.model.edge.KvesterEdge;
import sun.reflect.generics.reflectiveObjects.NotImplementedException;

public class RKvesterEdgeHandler extends KvesterEdgeHandler {
    @Override
    public KvesterEdge retrieveEdge(String parentId, Document parentDoc) {
        throw new NotImplementedException();
    }

}
