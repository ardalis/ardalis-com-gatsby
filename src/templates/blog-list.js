import React from "react"
import { Link, graphql } from "gatsby"
import Layout from "../components/Layout"
import PreviewCompatibleImage from '../components/PreviewCompatibleImage'
import Sidebar from '../components/sidebar'


export default class BlogList extends React.Component {
  render() {
    const posts = this.props.data.allMarkdownRemark.edges
    const { currentPage, numPages } = this.props.pageContext
    const isFirst = currentPage === 1 
    const isLast = currentPage === numPages
    const prevPage = currentPage - 1 === 1 ? "/" : (currentPage - 1).toString()
    const nextPage = (currentPage + 1).toString()
    return (
      <Layout>
        <div
          className="full-width-image-container margin-top-0"
          style={{
            backgroundImage: `url('/img/blogging.jpg')`,
          }}
        >
          <h1
            className="has-text-weight-bold is-size-1"
            style={{
              boxShadow: '0.5rem 0 0 #3571B8, -0.5rem 0 0 #3571B8',
              backgroundColor: 'rgba(53, 113, 184, 0.59)',
              color: 'white',
              padding: '1rem',
            }}
          >
            Latest Articles
          </h1>
        </div>

        <section className="section">
          <div className="container">
          <div class="tile is-ancestor">
          <div class="tile is-vertical is-8">
            <div class="tile">              
              <div class="tile is-parent">
                <article class="tile is-child box">
                <div className="content">
                <div className="columns is-multiline">  
        {posts.map(({ node }) => {
          const title = node.frontmatter.title || node.fields.slug
          return <div className="is-parent column is-6" key={node.fields.slug}>
          <article
                className={`blog-list-item tile is-child box notification ${
                  node.frontmatter.featuredpost ? 'is-featured' : ''
                }`}
              >
                <header>
                  {node.frontmatter.featuredimage ? (
                    <div className="featured-thumbnail">
                      <PreviewCompatibleImage
                        imageInfo={{
                          image: node.frontmatter.featuredimage,
                          alt: `featured image thumbnail for post ${title}`,
                        }}
                      />
                    </div>
                  ) : null}
                  
                </header>
                <p className="post-meta">
                    <Link
                      className="title has-text-primary is-size-4"
                      to={node.fields.slug}
                    >
                      {title}
                    </Link>
                    <span> </span>
                    <span className="subtitle is-size-5 is-block">
                      {node.frontmatter.date}
                    </span>
                  </p>
                <p><br />
                  {node.excerpt}
                  <br />
                  <br />
                  <Link className="button" to={node.fields.slug}>
                    Keep Reading →
                  </Link>
                </p>
              </article>
        </div>
        })}
        </div>
        <ul
          style={{
            display: 'flex',
            flexWrap: 'wrap',
            marginBottom: '2rem',
            marginTop: '2rem',
            alignItems: 'center',
            listStyle: 'none',
            padding: 0,
            marginLeft:'0%',
          }}
        >
       
         {currentPage === 2 ? (
            <Link to={`/blog`} rel="prev">
              ← Previous Page
            </Link> )
        : !isFirst && (
            <Link to={`/blog/page/${prevPage}`} rel="prev">
              ← Previous Page
            </Link>
          )}
          {Array.from({ length: numPages }, (_, i) => (
            <li
              key={`pagination-number${i + 1}`}
              style={{
                margin: 0,
              }}
            >
              <Link
                to={`/${i === 0 ? '/blog' : `/blog/page/${i + 1}`}`}
                style={{
                  padding: '0.42rem',
                  textDecoration: 'none',
                  color: i + 1 === currentPage ? '#ffffff' : '',
                  background: i + 1 === currentPage ? '#007acc' : '',
                }}
              >
                {i + 1}
              </Link>
            </li>
          ))}
          {!isLast && (
            <Link to={`/blog/page/${nextPage}`} rel="next">
              Next Page →
            </Link>
          )} 
        </ul>  
                </div>
                </article>
              </div>
            </div>
          </div>
         <div><Sidebar /></div>
        </div>  
          </div>
        </section>
        
       
      </Layout>
    )
  }
}
export const blogListQuery = graphql`
  query blogListQuery($skip: Int!, $limit: Int!) {
    allMarkdownRemark(
      sort: {  order: DESC, fields: [frontmatter___date] }
      filter: { frontmatter: { templateKey: { eq: "blog-post" } } }
      limit: $limit
      skip: $skip
    ) {
      edges {
        node {
          excerpt  
          fields {
            slug
          }
          frontmatter {
            title
            date(formatString: "DD MMMM YYYY")
            featuredpost
                featuredimage {
                  childImageSharp {
                    fluid(maxWidth: 450, quality: 100) {
                      ...GatsbyImageSharpFluid
                    }
                  }
                }
          }
        }
      }
    }
  }
`