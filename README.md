# Whimsy

A different kind of website. Ideally one filled with dungeoneering and dragons! (powered by htmx and phoenix and elixir and postgres)

# Architecture
HTML fragments follow a naming convention like this 
- in code: render(conn, :_success)
  - In this example there is an underscore before the html template render
- in template paths: _success.html.heex
  - In this template path, there is an underscore before the name

Note on the above convention: this creates nice and obvious visual clarity on how everything is set up. You can glance at a function, or a fragment and understand which is which. 

There is an HtmxPlug which removes the root layout and layout if the request is an htmx request. This is done by looking at the headers of the request. 

Any controller can support the use of fragments with a couple modifications like this 
- in the *_controller.ex file
  - add the line `use WhimsyWeb.HtmlFragments, base_path: "/encounters"`
    - _note: the base_path is a required field to set_
- in the *_html.ex file
  - add the line `import WhimsyWeb.EncounterController, only: [f: 1]`

