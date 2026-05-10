# Blackstone - Rails Project Guide

## Quick Start

```bash
# Install dependencies
bundle install

# Setup database
rails db:create db:migrate db:seed

# Start dev server
rails server
```

## Key Commands

| Command | Purpose |
|---------|---------|
| `rails c` | Rails console |
| `rails routes` | List all routes |
| `rails db:migrate` | Run migrations |
| `rails test` | Run tests |

## Project Structure

- **Admin panel**: `/admin` (requires `admin: true` on user)
- **Models**: `app/models/`
- **Controllers**: `app/controllers/` + `app/controllers/admin/`
- **Views**: `app/views/` (ERB templates)
- **Styles**: `app/assets/stylesheets/application.css` (dark theme)

## Important Routes

```
/                  → Home (featured tool + categories)
/categories       → Browse tools by category
/courses          → Course catalog
/mis-favoritos    → User favorites (auth required)
/admin            → Admin dashboard
```

## Tech Stack

- Rails 7.1.3 + Ruby 3.3.0
- PostgreSQL
- Hotwire (Turbo + Stimulus)
- Devise (authentication)
- Active Storage (file uploads)

## Database Config

Credentials in `config/database.yml`:
- User: `blackstone_user`
- Password: `1234` (change for production)
- DB: `blackstone_development`

## Key Patterns

- **Video progress**: Auto-saves every 15s, marks complete at 90%
- **Slugs**: Auto-generated from `name` field (Tool, Category)
- **Featured item**: Random tool featured daily on home
- **Admin auth**: Uses `before_action :authenticate_admin!` in `Admin::BaseController`

## Frontend

- Stimulus controllers in `app/javascript/controllers/`
- `video_player_controller.js` → YouTube API integration
- `modal_controller.js` → Contact form modal
- CSS uses CSS variables (dark theme: `--color-bg: #0f1117`)

## UI/UX Rules

- **All agents must consult and strictly follow the visual specifications defined in `DESIGN.md` for any UI/UX task**