
package intents;

import ai.grakn.GraknGraph;
import ai.grakn.concept.Concept;
import ai.grakn.graql.MatchQuery;
import ai.grakn.graql.Pattern;

import java.util.HashSet;
import java.util.Map;
import java.util.Random;
import java.util.Set;

import static ai.grakn.graql.Graql.var;

public class RandomIntent implements Intent {

    private GraknGraph graph;

    private Set<Pattern> queryPatterns;
    private static final Integer LIMIT = 100;

    public RandomIntent(GraknGraph graph){
        this.graph = graph;
        this.queryPatterns = new HashSet<>();
    }

    @Override
    public String execute() {

        queryPatterns.add(var("movie").isa("movie"));
        queryPatterns.add(var("movie").has("title", var("title")));
        queryPatterns.add(var("movie").has("overview", var("overview")));
        queryPatterns.add(var("movie").has("youtube-trailer", var("youtube-trailer")));

        MatchQuery match = graph.graql()
                .match(queryPatterns);

        match = match.distinct();
        match = match.limit(LIMIT);

        System.out.println(match);

        Map<String, Concept> result = match.execute().get(new Random().nextInt(LIMIT));

        return  result.get("title").asResource().getValue() + "\n" +
                result.get("overview").asResource().getValue() + "\n" +
                format(result.get("youtube-trailer").asResource().getValue().toString()) + "\n";
    }
}
