defmodule WhimsyWeb.HypermediaHTML do
  use WhimsyWeb, :html

  embed_templates "hypermedia_html/*"

  def experiments(assigns) do
    ~H"""
    <div id="main">
      <button
        hx-get="/hypermedia/contacts"
        hx-target="#main"
        hx-swap="outerHTML"
        hx-trigger="click, keyup[ctrlKey && key == 'l'] from:body"
      >
        Get the Contacts
      </button>
    </div>

    <br />

    <div id="exp2">
      <form>
        <label for="search">Search Term</label>
        <input
          id="search"
          type="search"
          name="q"
          value=""
          placeholder="Search Contacts"
        />
        <button hx-post="/hypermedia/contacts" hx-target="#exp2">
          Search
        </button>
      </form>
    </div>

    <br />

    <div id="exp3">
      <label for="search">Search Contacts:</label>
      <input id="search" name="q" type="search" value="" placeholder="SearchContacts" />
      <button hx-post="/hypermedia/contacts" hx-target="#exp3" hx-include="#search">
        Search
      </button>
    </div>

    <br />

    <div id="exp4">
      <button hx-get="/hypermedia/contacts" hx-vals='{"state":"MT"}'>
        Get Contacts In Montana
      </button>
    </div>

    <br />

    <div id="exp5">
      <button hx-get="/hypermedia/contacts" hx-target="#exp5" hx-push-url="true">
        Get the Contacts
      </button>
    </div>
    """
  end

  def _search_contacts(assigns) do
    ~H"""
    <p>Searching for {assigns.contact}</p>
    """
  end
end
