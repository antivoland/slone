/**
 * @author antivoland
 */
package ru.antimiaou.slone.extractor;

import com.google.inject.AbstractModule;
import com.google.inject.Guice;
import org.codehaus.jackson.map.ObjectMapper;
import ru.antimiaou.slone.extractor.conf.Conf;
import ru.antimiaou.slone.extractor.guice.ExtractorModule;
import ru.antimiaou.slone.extractor.model.KvesterExtractor;
import ru.antimiaou.slone.extractor.model.KvesterGame;

public class Main {
    public static void main(String[] args) throws Exception {
        App.conf = Conf.load();
        App.injector = Guice.createInjector(new ExtractorModule(), new AbstractModule() {
            @Override
            protected void configure() {
                binder().requireExplicitBindings();
            }
        });

        KvesterExtractor extractor = App.injector.getInstance(KvesterExtractor.class);
        KvesterGame game = new KvesterGame(extractor);
        game.extract();

        ObjectMapper mapper = new ObjectMapper();
        System.out.print(mapper.writeValueAsString(game));
    }
}