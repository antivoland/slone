/**
 * @author antivoland
 */
package ru.antimiaou.slone.extractor.conf.entity;

public class EdgeStyle {
    private boolean directed;
    private boolean error;

    public boolean isDirected() {
        return directed;
    }

    public void setDirected(boolean directed) {
        this.directed = directed;
    }

    public boolean isError() {
        return error;
    }

    public void setError(boolean error) {
        this.error = error;
    }
}
