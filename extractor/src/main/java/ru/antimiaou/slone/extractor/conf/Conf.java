/**
 * @author antivoland
 */
package ru.antimiaou.slone.extractor.conf;

import org.apache.commons.configuration.ConfigurationUtils;
import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.ObjectMapper;
import ru.antimiaou.slone.extractor.conf.entity.Edge;
import ru.antimiaou.slone.extractor.conf.entity.Node;

import java.io.IOException;
import java.net.URL;
import java.util.List;

public class Conf {
    private List<Node> nodes;
    private List<Edge> edges;

    public List<Node> getNodes() {
        return nodes;
    }

    public List<Edge> getEdges() {
        return edges;
    }

    public static Conf load() throws IOException {
        ObjectMapper mapper = new ObjectMapper();
        mapper.configure(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES, false);

        Conf conf = new Conf();
        URL nodesUrl = ConfigurationUtils.locate("conf/nodes.json");
        conf.nodes = mapper.readValue(nodesUrl, mapper.getTypeFactory().constructCollectionType(List.class, Node.class));

        URL edgesUrl = ConfigurationUtils.locate("conf/edges.json");
        conf.edges = mapper.readValue(edgesUrl, mapper.getTypeFactory().constructCollectionType(List.class, Edge.class));
        return conf;
    }
}
