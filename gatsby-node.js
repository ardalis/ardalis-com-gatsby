const _ = require('lodash')
const path = require('path')
const { createFilePath } = require('gatsby-source-filesystem')
const { fmImagesToRelative } = require('gatsby-remark-relative-images')

exports.createPages = ({ actions, graphql }) => {
  const { createPage } = actions

  return graphql(`
    {
      allMarkdownRemark(limit: 10000) {
        edges {
          node {
            id
            fields {
              slug
            }
            frontmatter {
              tags
              category
              templateKey
            }
          }
        }
      }
    }
  `).then((result) => {
    if (result.errors) {
      result.errors.forEach((e) => console.error(e.toString()))
      return Promise.reject(result.errors)
    }

    const posts = result.data.allMarkdownRemark.edges

    posts.forEach((edge) => {
      const id = edge.node.id
      createPage({
        path: edge.node.fields.slug,
        tags: edge.node.frontmatter.tags,
        component: path.resolve(
          `src/templates/${String(edge.node.frontmatter.templateKey)}.js`
        ),
        // additional data can be passed via context
        context: {
          id,
        },
      })
  



})

// Create blog post list pages
const postsPerPage = 10;
const numPages = Math.ceil(posts.length / postsPerPage);

Array.from({ length: numPages }).forEach((_, i) => {
 createPage({
   path: i === 0 ? `/blog` : `/blog/page/${i + 1}`,
   component: path.resolve("./src/templates/blog-list.js"),
   context: {
     limit: postsPerPage,
     skip: i * postsPerPage,
     numPages,  
     currentPage: i + 1,
   },
 });
});
    // Tag pages:
    let tags = []
    // Iterate through each post, putting all found tags into `tags`
    posts.forEach((edge) => {
      if (_.get(edge, `node.frontmatter.tags`)) {
        tags = tags.concat(edge.node.frontmatter.tags)
      }
    })
    // Eliminate duplicate tags
    tags = _.uniq(tags)

    // Make tag pages
    tags.forEach((tag) => {
      const tagPath = `/tags/${_.kebabCase(tag)}/`

      createPage({
        path: tagPath,
        component: path.resolve(`src/templates/tags.js`),
        context: {
          tag,
        },
      })
    })


// Category pages:
let category = []
// Iterate through each post, putting all found tags into `category`
posts.forEach((edge) => {
  if (_.get(edge, `node.frontmatter.category`)) {
    category = category.concat(edge.node.frontmatter.category)
  }
})
// Eliminate duplicate category
category = _.uniq(category)

// Make category pages
category.forEach((cat) => {
  const catPath = `/category/${_.kebabCase(cat)}/`

  createPage({
    path: catPath,
    component: path.resolve(`src/templates/category.js`),
    context: {
      cat,
    },
  })
})
})
}


exports.onCreateNode = ({ node, actions, getNode }) => {
  const { createNodeField } = actions
  fmImagesToRelative(node) // convert image paths for gatsby images

  if (node.internal.type === `MarkdownRemark`) {
    //const value = createFilePath({ node, getNode })
    //const value = node.frontmatter.path || createFilePath({ node, getNode })
    const blogPath = '/blog';
    let value = createFilePath({ node, getNode });
    value.startsWith(blogPath) && (value = value.replace(blogPath, ''));
    createNodeField({
      name: `slug`,
      node,
      value,
    })
  }
}
