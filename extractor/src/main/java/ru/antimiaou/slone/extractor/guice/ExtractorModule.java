/**
 * @author antivoland
 */
package ru.antimiaou.slone.extractor.guice;

import com.google.inject.AbstractModule;
import com.google.inject.Scopes;
import com.google.inject.name.Names;
import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;
import ru.antimiaou.slone.extractor.model.KvesterExtractor;

public class ExtractorModule extends AbstractModule {
    @Override
    protected void configure() {
        PropertiesConfiguration properties;
        try {
            properties = new PropertiesConfiguration("extractor.properties");
        } catch (ConfigurationException e) {
            throw new Error(e);
        }

        bind(String.class).annotatedWith(Names.named("kvester-main-url")).toInstance(properties.getString("kvester.url.main"));
        bind(String.class).annotatedWith(Names.named("kvester-node-url")).toInstance(properties.getString("kvester.url.node"));
        bind(String.class).annotatedWith(Names.named("kvester-route-url")).toInstance(properties.getString("kvester.url.route"));
        bind(String.class).annotatedWith(Names.named("kvester-visibility-url")).toInstance(properties.getString("kvester.url.visibility"));
        bind(String.class).annotatedWith(Names.named("kvester-links-url")).toInstance(properties.getString("kvester.url.links"));
        bind(String.class).annotatedWith(Names.named("kvester-link-url")).toInstance(properties.getString("kvester.url.link"));
        bind(String.class).annotatedWith(Names.named("kvester-items-url")).toInstance(properties.getString("kvester.url.items"));
        bind(String.class).annotatedWith(Names.named("kvester-item-url")).toInstance(properties.getString("kvester.url.item"));
        bind(String.class).annotatedWith(Names.named("kvester-counters-url")).toInstance(properties.getString("kvester.url.counters"));
        bind(String.class).annotatedWith(Names.named("kvester-image-url")).toInstance(properties.getString("kvester.url.image"));
        bind(String.class).annotatedWith(Names.named("kvester-cookie")).toInstance(properties.getString("kvester.cookie"));

        bind(KvesterExtractor.class).in(Scopes.SINGLETON);
    }
}
