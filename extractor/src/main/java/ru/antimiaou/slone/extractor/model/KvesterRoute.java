/**
 * @author antivoland
 */
package ru.antimiaou.slone.extractor.model;

import ru.antimiaou.slone.extractor.model.edge.KvesterEdge;
import ru.antimiaou.slone.extractor.model.visibility.KvesterVisibility;

public class KvesterRoute {
    private String id;
    private String nodeFrom;
    private KvesterEdge edge;
    private KvesterVisibility visibility;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNodeFrom() {
        return nodeFrom;
    }

    public void setNodeFrom(String nodeFrom) {
        this.nodeFrom = nodeFrom;
    }

    public KvesterEdge getEdge() {
        return edge;
    }

    public void setEdge(KvesterEdge edge) {
        this.edge = edge;
    }

    public KvesterVisibility getVisibility() {
        return visibility;
    }

    public void setVisibility(KvesterVisibility visibility) {
        this.visibility = visibility;
    }
}
