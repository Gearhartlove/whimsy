defmodule WhimsyWeb.HtmxControllerTest do
  use WhimsyWeb.ConnCase

  describe "GET /htmx/greeting" do
    test "returns a random greeting", %{conn: conn} do
      conn = get(conn, ~p"/htmx/greeting")
      response = html_response(conn, 200)

      # Should contain one of the expected greetings
      greetings = [
        "Hello, adventurer!",
        "Greetings, brave soul!",
        "Welcome, weary traveler!",
        "Hail, noble hero!",
        "Well met, wanderer!"
      ]

      assert Enum.any?(greetings, &String.contains?(response, &1))
    end

    test "returns HTML fragment without layout", %{conn: conn} do
      conn = get(conn, ~p"/htmx/greeting")
      response = html_response(conn, 200)

      # Should not contain full HTML document structure
      refute String.contains?(response, "<!DOCTYPE")
      refute String.contains?(response, "<html")

      # Should contain our fragment markup
      assert String.contains?(response, "text-primary")
    end
  end

  describe "GET /htmx/roll" do
    test "rolls a d20 by default", %{conn: conn} do
      conn = get(conn, ~p"/htmx/roll")
      response = html_response(conn, 200)

      assert String.contains?(response, "d20")
    end

    test "rolls specified dice sides", %{conn: conn} do
      conn = get(conn, ~p"/htmx/roll?sides=6")
      response = html_response(conn, 200)

      assert String.contains?(response, "d6")
    end

    test "returns HTML fragment without layout", %{conn: conn} do
      conn = get(conn, ~p"/htmx/roll")
      response = html_response(conn, 200)

      # Should not contain full HTML document structure
      refute String.contains?(response, "<!DOCTYPE")
      refute String.contains?(response, "<html")

      # Should contain our fragment markup
      assert String.contains?(response, "text-accent")
    end

    test "dice result is within valid range for d6", %{conn: conn} do
      # Run multiple times to check range
      results =
        for _ <- 1..20 do
          conn = get(conn, ~p"/htmx/roll?sides=6")
          response = html_response(conn, 200)

          # Extract the number from the response
          # The result is in a div with class text-4xl
          [[_, num_str]] = Regex.scan(~r/<div class="text-4xl[^"]*">\s*(\d+)\s*<\/div>/, response)
          String.to_integer(num_str)
        end

      # All results should be between 1 and 6
      assert Enum.all?(results, fn r -> r >= 1 and r <= 6 end)
    end
  end
end
