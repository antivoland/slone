/**
 * @author antivoland
 */
package ru.antimiaou.slone.extractor.model;

import ru.antimiaou.slone.extractor.model.edge.KvesterEdge;
import ru.antimiaou.slone.extractor.model.visibility.KvesterVisibility;

public class KvesterLink {
    private String id;
    private boolean bottom;
    private KvesterEdge edge;
    private KvesterVisibility visibility;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public boolean isBottom() {
        return bottom;
    }

    public void setBottom(boolean bottom) {
        this.bottom = bottom;
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
