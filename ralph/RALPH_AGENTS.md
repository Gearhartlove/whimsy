# Ralph Agent Learnings

## Phoenix HTMX Integration Patterns

### Adding Vendor Libraries
- Place JS libraries in `assets/vendor/` directory
- Import in `assets/js/app.js` using relative path: `import htmx from "../vendor/htmx.min.js"`

### HTMX CSRF Configuration
- Phoenix uses CSRF tokens for POST/PUT/DELETE protection
- Configure HTMX to send token via `htmx:configRequest` event:
```javascript
document.body.addEventListener('htmx:configRequest', (event) => {
  event.detail.headers['x-csrf-token'] = csrfToken
})
```

### Returning HTML Fragments (No Layout)
- **Critical**: Must disable BOTH root layout AND app layout
- Use `put_root_layout(false)` AND `put_layout(false)` in controller
- Without both, Phoenix wraps fragments in full HTML document

### Controller Pattern for HTMX
```elixir
def action(conn, _params) do
  conn
  |> put_root_layout(false)
  |> put_layout(false)
  |> render(:template_name, assigns: value)
end
```

### Template Structure
- HTMX templates go in `controllers/htmx_html/` directory
- HTML module uses `embed_templates "htmx_html/*"`
- Templates should be minimal HTML fragments, not full pages

