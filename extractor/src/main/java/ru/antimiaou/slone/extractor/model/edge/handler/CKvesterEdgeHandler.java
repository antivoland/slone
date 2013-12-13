/**
 * @author antivoland
 */
package ru.antimiaou.slone.extractor.model.edge.handler;

import org.jsoup.nodes.Document;
import ru.antimiaou.slone.extractor.model.KvesterGame;
import ru.antimiaou.slone.extractor.model.edge.CKvesterEdge;
import ru.antimiaou.slone.extractor.model.edge.KvesterEdge;

public class CKvesterEdgeHandler extends KvesterEdgeHandler {
    @Override
    public KvesterEdge retrieveEdge(String parentId, Document parentDoc) {
        CKvesterEdge edge = new CKvesterEdge();

        String conditionsSel = "action[" + parentId + "][0][condition][]";
        edge.setConditions(KvesterGame.retrieveCheckedIds(parentDoc, conditionsSel));

        edge.setSuccessAction(retrieveAction(parentId, parentDoc, 0));
        edge.setFailAction(retrieveAction(parentId, parentDoc, 1));
        return edge;
    }

}
