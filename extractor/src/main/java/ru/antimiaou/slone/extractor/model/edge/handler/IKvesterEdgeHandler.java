/**
 * @author antivoland
 */
package ru.antimiaou.slone.extractor.model.edge.handler;

import org.jsoup.nodes.Document;
import ru.antimiaou.slone.extractor.model.KvesterGame;
import ru.antimiaou.slone.extractor.model.edge.IKvesterEdge;
import ru.antimiaou.slone.extractor.model.edge.KvesterEdge;

public class IKvesterEdgeHandler extends KvesterEdgeHandler {
    @Override
    public KvesterEdge retrieveEdge(String parentId, Document parentDoc) {
        IKvesterEdge edge = new IKvesterEdge();

        String addInventoriesSel = "action[" + parentId + "][0][condition][add][]";
        edge.setAddInventories(KvesterGame.retrieveCheckedIds(parentDoc, addInventoriesSel));

        String subInventoriesSel = "action[" + parentId + "][0][condition][sub][]";
        edge.setSubInventories(KvesterGame.retrieveCheckedIds(parentDoc, subInventoriesSel));

        edge.setAction(retrieveAction(parentId, parentDoc, 0));
        return edge;
    }

}
