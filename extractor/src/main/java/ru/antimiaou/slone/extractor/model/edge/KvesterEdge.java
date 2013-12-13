/*
 * @author antivoland
 */
package ru.antimiaou.slone.extractor.model.edge;

public class KvesterEdge {
    private KvesterEdgeType type;
    private String name;

    public KvesterEdgeType getType() {
        return type;
    }

    public void setType(KvesterEdgeType type) {
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
