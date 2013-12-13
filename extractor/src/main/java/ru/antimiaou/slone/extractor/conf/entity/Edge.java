/**
 * @author antivoland
 */
package ru.antimiaou.slone.extractor.conf.entity;

public class Edge {
    private String source;
    private String target;
    private EdgeStyle style;

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }

    public EdgeStyle getStyle() {
        return style;
    }

    public void setStyle(EdgeStyle style) {
        this.style = style;
    }
}
