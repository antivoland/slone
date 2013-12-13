/**
 * @author antivoland
 */
package ru.antimiaou.slone.extractor.model.visibility;

import java.util.Set;

public class KvesterVisibility {
    private KvesterVisibilityType type;
    private Set<String> inventories;

    public KvesterVisibilityType getType() {
        return type;
    }

    public void setType(KvesterVisibilityType type) {
        this.type = type;
    }

    public Set<String> getInventories() {
        return inventories;
    }

    public void setInventories(Set<String> inventories) {
        this.inventories = inventories;
    }
}
