
import ai.grakn.GraknGraph;

import static spark.Spark.port;
import static spark.Spark.post;
import static spark.Spark.get;

// sudo kill $(sudo lsof -t -i:8080)

public class Main {

    private static GraknGraph mGraph;

    public static void main(String[] args) {
        get("/hello", (req, res) -> "Hello World");
    }

}

