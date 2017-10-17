
import ai.grakn.Grakn;
import ai.grakn.GraknGraph;

import ch.qos.logback.classic.Level;
import ch.qos.logback.classic.Logger;
import mjson.Json;
import spark.Request;
import spark.Response;

import static spark.Spark.port;
import static spark.Spark.get;
import static spark.Spark.post;

import intents.Intent;
import intents.MovieInformationIntent;
import intents.MovieSearchIntent;
import intents.RandomIntent;

// sudo kill $(sudo lsof -t -i:8080)

public class Main {

    private static final String KEYSPACE = "grakn";

    private static GraknGraph mGraph;

    public static void main(String[] args) {

        disableInternalLogs();

        mGraph = Grakn.factory(Grakn.DEFAULT_URI, KEYSPACE).getGraph();

        port(8080);

        get("/running", Main::running);
        post("/query", Main::query);

        //get("/hello", (req, res) -> "Hello World");
    }

    private static String running(Request request, Response response){
        return "Query engine running";
    }

    private static String query(Request request, Response response){
        Json result = Json.read(request.body()).at("result");

        System.out.println(result);

        Intent intent = determineIntent(result);
        String displayText = intent.execute();

        System.out.println(displayText);

        return createResponse(displayText, response);
    }

    private static Intent determineIntent(Json result){
        String action = result.at("action").asString();

        switch (action){
            case "search":
                return new MovieSearchIntent(result.at("parameters"), mGraph);
            case "information":
                return new MovieInformationIntent(result.at("parameters"), mGraph);
            case "random":
                return new RandomIntent(mGraph);
        }

        throw new RuntimeException("Can not handle this type of query");
    }

    /**
     * Create the response to return to api.ai
     */
    private static String createResponse(String displayText, Response response){
        Json slackMessage = Json.object().set("text", displayText);
        Json data = Json.object().set("slack", slackMessage);

        Json responseBody = Json.object().set("data", data);

        response.body(responseBody.toString());
        response.header("Content-type", "application/json");

        return responseBody.toString();
    }

    private static void disableInternalLogs(){
        Logger logger = (Logger) org.slf4j.LoggerFactory.getLogger(org.slf4j.Logger.ROOT_LOGGER_NAME);
        logger.setLevel(Level.OFF);
    }
}

