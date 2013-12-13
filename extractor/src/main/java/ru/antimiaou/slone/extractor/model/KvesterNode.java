/**
 * @author antivoland
 */
package ru.antimiaou.slone.extractor.model;

import java.util.List;

public class KvesterNode {
    private String id;
    private String name;
    private String imageUrl;
    private String descr;
    private List<KvesterRoute> routes;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getDescr() {
        return descr;
    }

    public void setDescr(String descr) {
        this.descr = descr;
    }

    public List<KvesterRoute> getRoutes() {
        return routes;
    }

    public void setRoutes(List<KvesterRoute> routes) {
        this.routes = routes;
    }
}
