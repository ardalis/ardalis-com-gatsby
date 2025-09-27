# Hugo Blog Beta Setup

This is an experimental Hugo-based version of the Ardalis blog, located in the `/beta` folder.

## Prerequisites

1. Install Hugo: https://gohugo.io/installation/
2. Make sure Go is installed (Hugo is built with Go)

## Getting Started

### 1. Navigate to the beta directory
```powershell
cd beta
```

### 2. Start the development server
```powershell
hugo server -D
```

The site will be available at `http://localhost:1313`

### 3. Build for production
```powershell
hugo
```

This creates a `public/` directory with the generated static site.

## Project Structure

```
beta/
├── hugo.yaml           # Hugo configuration
├── content/           # Blog content (Markdown files)
│   ├── _index.md     # Home page
│   └── blog/         # Blog posts
├── themes/ardalis/   # Custom theme
│   └── layouts/      # HTML templates
├── static/           # Static assets (CSS, JS, images)
└── public/           # Generated site (after build)
```

## Key Differences from Gatsby

1. **Front Matter**: Hugo uses YAML front matter with different field names
2. **Content Organization**: Hugo uses the content directory structure for URLs
3. **Templates**: Hugo uses Go templates instead of React components
4. **Build Process**: Single binary, no npm dependencies
5. **Performance**: Extremely fast build times

## Available Commands

- `hugo server -D`: Start development server with drafts
- `hugo server`: Start development server (published content only)
- `hugo`: Build static site
- `hugo new blog/my-post.md`: Create new blog post

## Configuration

The main configuration is in `hugo.yaml`. Key settings include:
- Site metadata (title, description, author)
- Menu configuration
- Taxonomy settings (tags, categories)
- Theme selection

## Theme Customization

The custom theme is located in `themes/ardalis/layouts/`. Main templates:
- `_default/baseof.html`: Base template with header/footer
- `index.html`: Home page template
- `_default/single.html`: Individual blog post template
- `_default/list.html`: Blog listing template

## Next Steps

1. Try building and previewing the site
2. Customize the theme and styling
3. Add more content
4. Configure deployment (Netlify, Vercel, etc.)
5. Set up CI/CD pipeline if needed