/**
 * @author antivoland
 */
package ru.antimiaou.slone.extractor.model;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import ru.antimiaou.slone.extractor.model.edge.KvesterEdge;
import ru.antimiaou.slone.extractor.model.edge.KvesterEdgeType;
import ru.antimiaou.slone.extractor.model.visibility.KvesterVisibility;
import ru.antimiaou.slone.extractor.model.visibility.KvesterVisibilityType;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class KvesterGame {
    private static final Logger log = Logger.getLogger(KvesterGame.class);

    private static final String NODE_BEGIN_STR = "g.addNode(\"";
    private static final String NODE_END_STR = "\",{";
    private static final String EDGE_BEGIN_STR = "loadIfStep(";
    private static final String EDGE_END_STR = ")";
    private static final String LINK_BEGIN_STR = "editLink(";
    private static final String LINK_END_STR = ");";
    private static final String ITEM_BEGIN_STR = "editInventory(";
    private static final String ITEM_END_STR = ");";

    private final KvesterExtractor extractor;

    private List<KvesterNode> nodes;
    private List<KvesterLink> links;
    private List<KvesterItem> items;

    public KvesterGame(KvesterExtractor extractor) {
        this.extractor = extractor;
    }

    public List<KvesterNode> getNodes() {
        return nodes;
    }

    public List<KvesterLink> getLinks() {
        return links;
    }

    public List<KvesterItem> getItems() {
        return items;
    }

    public void extract() {
        Document mainDoc = extractor.retrieveMainDoc();
        nodes = retrieveNodes(mainDoc);

        Document linksDoc = extractor.retrieveLinksDoc();
        links = retrieveLinks(linksDoc);

        Document itemsDoc = extractor.retrieveItemsDoc();
        items = retrieveItems(itemsDoc);
    }

    private List<KvesterNode> retrieveNodes(Document mainDoc) {
        List<KvesterNode> nodes = new ArrayList<KvesterNode>();
        Elements scripts = mainDoc.getElementsByTag("script");
        for (Element script : scripts) {
            String scriptData = script.data();
            int beginIndex = scriptData.indexOf(NODE_BEGIN_STR);
            if (beginIndex >= 0) {
                while (beginIndex >= 0) {
                    int endIndex = scriptData.indexOf(NODE_END_STR, beginIndex);
                    String nodeId = scriptData.substring(beginIndex + NODE_BEGIN_STR.length(), endIndex);
                    nodes.add(retrieveNode(nodeId));
                    beginIndex = scriptData.indexOf(NODE_BEGIN_STR, endIndex);
                }
            }
        }
        return nodes;
    }

    private KvesterNode retrieveNode(String nodeId) {
        Document nodeDoc = extractor.retrieveNodeDoc(nodeId);

        KvesterNode node = new KvesterNode();
        node.setId(nodeId);

        Element name = nodeDoc.getElementsByAttributeValue("name", "name").first();
        node.setName(name.attr("value"));

        Element image = nodeDoc.getElementById("point_image_src");
        if (image != null) {
            node.setImageUrl(String.format(extractor.imageUrl, image.attr("src")));
            extractor.cacheImage(node.getImageUrl(), "node-" + nodeId + "-img.jpg");
        } else {
            log.debug("Missing image url [nodeId=" + nodeId + "]");
        }

        Element descr = nodeDoc.getElementsByAttributeValue("name", "descr").first();
        node.setName(descr.text());

        node.setRoutes(retrieveRoutes(nodeDoc));
        return node;
    }

    private List<KvesterRoute> retrieveRoutes(Document nodeDoc) {
        List<KvesterRoute> routes = new ArrayList<KvesterRoute>();
        Elements scripts = nodeDoc.getElementsByTag("script");
        for (Element script : scripts) {
            if (script.data().contains(EDGE_BEGIN_STR)) {
                int beginIndex = script.data().indexOf(EDGE_BEGIN_STR);
                int endIndex = script.data().indexOf(EDGE_END_STR, beginIndex);
                String[] args = script.data().substring(beginIndex + 1, endIndex).replace("'", "").split(",");
                routes.add(retrieveRoute(args[1], args[2]));
            }
        }
        return routes;
    }

    private KvesterRoute retrieveRoute(String nodeId, String routeId) {
        KvesterRoute route = new KvesterRoute();
        route.setNodeFrom(nodeId);

        Document routeDoc = extractor.retrieveRouteDoc(nodeId, routeId);
        route.setEdge(retrieveEdge(routeId, routeDoc));

        String visibility = retrieveVisibilityStr(routeId, routeDoc);
        if (!StringUtils.isEmpty(visibility)) {
            Document visibilityDoc = extractor.retrieveRouteVisibilityDoc(nodeId, routeId, visibility);
            route.setVisibility(retrieveVisibility(visibilityDoc));
        }
        return route;
    }

    private List<KvesterLink> retrieveLinks(Document linksDoc) {
        List<KvesterLink> links = new ArrayList<KvesterLink>();
        for (Element link : linksDoc.select("li span.keditor_link")) {
            String strLink = link.attr("onclick");
            int beginIndex = strLink.indexOf(LINK_BEGIN_STR);
            int endIndex = strLink.indexOf(LINK_END_STR, beginIndex);
            strLink = strLink.substring(beginIndex + LINK_BEGIN_STR.length(), endIndex);
            String[] args = strLink.replace("'", "").split(",");
            links.add(retrieveLink(args[1]));
        }
        return links;
    }

    private KvesterLink retrieveLink(String linkId) {
        Document linkDoc = extractor.retrieveLinkDoc(linkId);

        KvesterLink link = new KvesterLink();
        link.setId(linkId);

        String bottomSel = "links[" + linkId + "][bottom]";
        Element bottom = linkDoc.getElementsByAttributeValue("name", bottomSel).first();
        link.setBottom("checked".equals(bottom.attr("checked")));

        link.setEdge(retrieveEdge(linkId, linkDoc));

        String visibility = retrieveVisibilityStr(linkId, linkDoc);
        if (!StringUtils.isEmpty(visibility)) {
            Document visibilityDoc = extractor.retrieveLinkVisibilityDoc(linkId, visibility);
            link.setVisibility(retrieveVisibility(visibilityDoc));
        }
        return link;
    }

    private List<KvesterItem> retrieveItems(Document inventoryDoc) {
        List<KvesterItem> items = new ArrayList<KvesterItem>();
        Elements elements = inventoryDoc.getElementsByClass("keditor_link");
        for (Element e : elements) {
            KvesterItem item = retrieveItem(e);
            if (!"0".equals(item.getItemId())) {
                retrieveExtendedItem(item);
                items.add(item);
            }
        }
        return items;
    }

    private KvesterItem retrieveItem(Element e) {
        String strLink = e.attr("onclick");
        int beginIndex = strLink.indexOf(ITEM_BEGIN_STR);
        int endIndex = strLink.indexOf(ITEM_END_STR, beginIndex);
        strLink = strLink.substring(beginIndex + ITEM_BEGIN_STR.length(), endIndex);
        String[] ids = strLink.replace("'", "").split(",");
        KvesterItem item = new KvesterItem();
        item.setQuestId(ids[0]);
        item.setItemId(ids[1]);
        item.setLabel(e.text());
        return item;
    }

    private void retrieveExtendedItem(KvesterItem item) {
        Document itemDoc = extractor.retrieveItemDoc(item.getItemId());

        Element show = itemDoc.getElementsByAttributeValue("name", "inventory[show]").first();
        item.setVisible("checked".equals(show.attr("checked")));

        Element start = itemDoc.getElementsByAttributeValue("name", "inventory[start]").first();
        item.setStart("checked".equals(start.attr("checked")));
    }

    public static KvesterEdgeType retrieveEdgeType(Document edgeDoc, String typeSel) {
        Element type = edgeDoc.getElementsByAttributeValue("name", typeSel).first()
                .getElementsByAttributeValue("selected", "selected").first();
        return KvesterEdgeType.valueOf(type.attr("value"));
    }

    public static KvesterEdge retrieveEdge(String parentId, Document parentDoc) {
        String typeSel = "links[" + parentId + "][action]";
        KvesterEdgeType type = retrieveEdgeType(parentDoc, typeSel);
        return type.retrieveEdge(parentId, parentDoc);
    }

    public static String retrieveVisibilityStr(String parentId, Document parentDoc) {
        String visibilitySel = "links[" + parentId + "][visible]";
        Element visibility = parentDoc.getElementsByAttributeValue("name", visibilitySel).first();
        return visibility.attr("value");
    }

    public static KvesterVisibility retrieveVisibility(Document visibilityDoc) {
        KvesterVisibility visibility = new KvesterVisibility();
        visibility.setType(retrieveVisibilityType(visibilityDoc));

        String inventoriesSel = "inventories[]";
        visibility.setInventories(retrieveCheckedIds(visibilityDoc, inventoriesSel));
        return visibility;
    }

    public static KvesterVisibilityType retrieveVisibilityType(Document visibilityDoc) {
        String typeSel = "inventory_type";
        Element type = visibilityDoc.getElementsByAttributeValue("name", typeSel).first()
                .getElementsByAttributeValue("selected", "selected").first();
        return "0".equals(type.attr("value")) ? KvesterVisibilityType.HIDE : KvesterVisibilityType.SHOW;
    }

    public static Set<String> retrieveCheckedIds(Document doc, String sel) {
        Set<String> checkedIds = new HashSet<String>();
        for (Element id : doc.getElementsByAttributeValue("name", sel)) {
            if ("checked".equals(id.attr("checked"))) {
                checkedIds.add(id.attr("value"));
            }
        }
        return checkedIds;
    }
}
