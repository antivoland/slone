/**
 * @author antivoland
 */
package ru.antimiaou.slone.extractor.model;

import com.google.inject.Inject;
import com.google.inject.name.Named;
import org.apache.log4j.Logger;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLConnection;
import java.util.Random;
import java.util.Scanner;

public class KvesterExtractor {
    private static final Logger log = Logger.getLogger(KvesterExtractor.class);

    public final String mainUrl;
    public final String nodeUrl;
    public final String routeUrl;
    public final String linksUrl;
    public final String linkUrl;
    public final String visibilityUrl;
    public final String itemsUrl;
    public final String itemUrl;
    public final String countersUrl;
    public final String imageUrl;
    public final String cookie;

    @Inject
    public KvesterExtractor(
            @Named("kvester-main-url") String mainUrl,
            @Named("kvester-node-url") String nodeUrl,
            @Named("kvester-route-url") String routeUrl,
            @Named("kvester-links-url") String linksUrl,
            @Named("kvester-link-url") String linkUrl,
            @Named("kvester-visibility-url") String visibilityUrl,
            @Named("kvester-items-url") String itemsUrl,
            @Named("kvester-item-url") String itemUrl,
            @Named("kvester-counters-url") String countersUrl,
            @Named("kvester-image-url") String imageUrl,
            @Named("kvester-cookie") String cookie
    ) {
        this.mainUrl = mainUrl;
        this.nodeUrl = nodeUrl;
        this.routeUrl = routeUrl;
        this.linksUrl = linksUrl;
        this.linkUrl = linkUrl;
        this.visibilityUrl = visibilityUrl;
        this.itemsUrl = itemsUrl;
        this.itemUrl = itemUrl;
        this.countersUrl = countersUrl;
        this.imageUrl = imageUrl;
        this.cookie = cookie;
    }

    public Document retrieveMainDoc() {
        log.info("Retrieving main document");
        String url = String.format(mainUrl);
        return getHtmlDoc(url, "main.nfo");
    }

    public Document retrieveNodeDoc(String nodeId) {
        log.info("Retrieving node " + nodeId);
        String url = String.format(nodeUrl, nodeId);
        return getHtmlDoc(url, "node-" + nodeId + ".nfo");
    }

    public Document retrieveRouteDoc(String nodeId, String routeId) {
        log.info("Retrieving route " + nodeId + ":" + routeId);
        String url = String.format(routeUrl, nodeId, routeId);
        return getHtmlDoc(url, "route-" + nodeId + "-" + routeId + ".nfo");
    }

    public Document retrieveRouteVisibilityDoc(String nodeId, String routeId, String visibility) {
        log.info("Retrieving route " + nodeId + ":" + routeId + " visibility");
        String url = String.format(visibilityUrl, visibility);
        return getHtmlDoc(url, "route-" + nodeId + "-" + routeId + "-visibility.nfo");
    }

    public Document retrieveLinksDoc() {
        log.info("Retrieving links document");
        String url = String.format(linksUrl);
        return getHtmlDoc(url, "links.nfo");
    }

    public Document retrieveLinkDoc(String linkId) {
        log.info("Retrieving link " + linkId);
        String url = String.format(linkUrl, linkId);
        return getHtmlDoc(url, "link-" + linkId + ".nfo");
    }

    public Document retrieveLinkVisibilityDoc(String linkId, String visibility) {
        log.info("Retrieving link " + linkId + " visibility");
        String url = String.format(visibilityUrl, visibility);
        return getHtmlDoc(url, "link-" + linkId + "-visibility.nfo");
    }

    public Document retrieveItemsDoc() {
        log.info("Retrieving items document");
        String url = String.format(itemsUrl);
        return getHtmlDoc(url, "items.nfo");
    }

    public Document retrieveItemDoc(String itemId) {
        log.info("Retrieving item " + itemId);
        String url = String.format(itemUrl, itemId);
        return getHtmlDoc(url, "item-" + itemId + ".nfo");
    }

    public Document retrieveCountersDoc() {
        log.info("Retrieving counters document");
        String url = String.format(countersUrl);
        return getHtmlDoc(url, "counters.nfo");
    }

    private Document getHtmlDoc(String url, String cacheKey) {
        String html;
        try {
            html = cacheHtmlDoc(url, cacheKey);
        } catch (IOException e) {
            throw new Error(e);
        }
        return Jsoup.parse(html);
    }

    private String cacheHtmlDoc(String url, String cacheKey) throws IOException {
        File file = new File(cacheKey);
        if (file.exists()) {
            return new Scanner(file).useDelimiter("\\A").next();
        }

        String html = getHtml(url);
        PrintWriter out = new PrintWriter(cacheKey);
        out.println(html);
        out.close();
        return html;
    }

    public void cacheImage(String url, String cacheKey) {
        File file = new File(cacheKey);
        if (file.exists()) {
            return;
        }

        InputStream stream = getStream(url);
        BufferedImage image;
        try {
            image = ImageIO.read(stream);
            ImageIO.write(image, "jpg", file);
        } catch (IOException e) {
            throw new Error(e);
        }
    }

    private String getHtml(String url) {
        InputStream stream = getStream(url);
        Scanner scanner = new Scanner(stream);
        scanner.useDelimiter("\\A");
        return scanner.next();
    }

    public InputStream getStream(String url) {
        InputStream stream = null;
        do {
            try {
                stream = get(url);
            } catch (IOException e) {
                log.warn(e.getMessage());
                try {
                    Thread.sleep(3000 + new Random().nextInt(5000));
                } catch (InterruptedException ex) {
                    ex.printStackTrace();
                }
            }
        } while (stream == null);
        return stream;
    }

    private InputStream get(String url) throws IOException {
        URLConnection connection = new URL(url).openConnection();
        connection.setRequestProperty("Cookie", cookie);
        return connection.getInputStream();
    }
}
