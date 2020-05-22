require("dotenv").config({
  path: `.env.${process.env.NODE_ENV}`,
})

module.exports = {
  siteMetadata: {
    title: 'Ardalis is Steve Smith - ardalis',
    author:'Steve Smith',
    description:
      'Steve is an experienced software architect and trainer, focusing currently on ASP.NET Core and Domain-Driven Design.',
      social: {
        twitter: `ardalis`,
      },
  },
  plugins: [
    'gatsby-plugin-react-helmet',
    `gatsby-plugin-twitter`,
    'gatsby-plugin-sass',
    {
      // keep as first gatsby-source-filesystem plugin for gatsby image support
      resolve: 'gatsby-source-filesystem',
      options: {
        path: `${__dirname}/static/img`,
        name: 'uploads',
      },
    },
    {
      resolve: 'gatsby-source-filesystem',
      options: {
        path: `${__dirname}/src/pages`,
        name: 'pages',
      },
    },
    {
      resolve: 'gatsby-source-filesystem',
      options: {
        path: `${__dirname}/src/img`,
        name: 'images',
      },
    },

    {
      resolve: 'gatsby-plugin-mailchimp',
      options: {
          endpoint: 'https://ardalis.us13.list-manage.com/subscribe/post?u=ddf5f72371bc4c837a6667f27&amp;id=40af84bfa3', 
      },
  },
    'gatsby-plugin-sharp',
    `gatsby-plugin-material-ui`,
    'disqus-react',
    'gatsby-transformer-sharp',
    'react-markdown',
    {
      resolve: 'gatsby-transformer-remark',
      options: {
        plugins: [
          {
            resolve: 'gatsby-remark-relative-images',
            options: {
              name: 'uploads',
            },
          },
          {
            resolve: 'gatsby-remark-images',
            options: {
              // It's important to specify the maxWidth (in pixels) of
              // the content container as this plugin uses this as the
              // base for generating different widths of each image.
              maxWidth: 2048,
            },
          },
          {
            resolve: 'gatsby-remark-copy-linked-files',
            options: {
              destinationDir: 'static',
            },
          },
        ],
      },
    },
    
    {
      resolve: 'gatsby-plugin-netlify-cms',
      options: {
        modulePath: `${__dirname}/src/cms/cms.js`,
      },
    },
    {
      resolve: 'gatsby-plugin-purgecss', // purges all unused/unreferenced css rules
      options: {
        develop: true, // Activates purging in npm run develop
        purgeOnly: ['/all.sass'], // applies purging only on the bulma css file
      },
    }, // must be after other CSS plugins
    'gatsby-plugin-netlify', // make sure to keep it last in the array
  ],
}
