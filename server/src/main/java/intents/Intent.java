
package intents;

import ai.grakn.concept.Concept;
import ai.grakn.concept.Resource;
import ai.grakn.concept.Type;
import ai.grakn.graql.MatchQuery;
import ai.grakn.graql.Order;
import mjson.Json;

import java.util.Collection;
import java.util.Map;

import static java.util.stream.Collectors.joining;

public interface Intent {

    public String execute();

    /**
     * Limit the number of results
     */
    default MatchQuery limit(MatchQuery query, Json parameters){
        if(parameters.at("limit").asString().equals("")){
            return query;
        }

        query = query.limit(parameters.at("limit").asInteger());

        return query;
    }

    /**
     * Order by degree
     */
    default MatchQuery order(MatchQuery query, Json parameters){
        if(parameters.at("order").asString().equals("")){
            return query;
        }

        switch (parameters.at("order").asString()){
            case "asc":
                query = query.orderBy("degree", Order.asc);
                break;
            case "desc":
                query = query.orderBy("degree" , Order.desc);
                break;
        }

        return query;
    }

    default String format(String result){
        if(result.startsWith("www.youtube")){
            return "https://" + result;
        }
        return result;
    }

    default String print(Collection<Map<String, Concept>> results){
        return results.stream()
                .filter(m -> m.containsKey("identifier"))
                .map(m -> m.get("identifier"))
                .map(Concept::asResource)
                .map(Resource::getValue)
                .map(Object::toString)
                .map(this::format)
                .distinct()
                .collect(joining("\n"));
    }

    /**
     * Returns the types that contains the primary information about the given type.
     * For example, the type "person" is best described by the resource type "name".
     */
    default String getPrimaryKeyType(Type type){
        if(type.isRoleType()){
            type = type.asRoleType().playedByTypes().stream().findFirst().get();
        }

        switch (type.getName()){
            case "person":
                return "name";
            case "genre":
                return "description";
            case "location":
                return "name";
            case "language":
                return "name";
            case "keyword":
                return "name";
            case "movie":
                return "title";
            case "character":
                return "name";
        }

        throw new RuntimeException("Unsupported type");
    }
}
