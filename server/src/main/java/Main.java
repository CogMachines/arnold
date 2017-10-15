import static spark.Spark.*;

// sudo kill $(sudo lsof -t -i:8080)

public class Main {

    public static void main(String[] args) {
        get("/hello", (req, res) -> "Hello World");
    }

}

