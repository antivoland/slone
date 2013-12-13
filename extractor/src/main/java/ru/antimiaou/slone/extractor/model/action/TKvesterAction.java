/**
 * @author antivoland
 */
package ru.antimiaou.slone.extractor.model.action;

public class TKvesterAction extends KvesterAction {
    private String message;
    private boolean hide; // после действия скрыть шаг

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public boolean isHide() {
        return hide;
    }

    public void setHide(boolean hide) {
        this.hide = hide;
    }
}
