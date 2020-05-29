import React from 'react'
import { Helmet } from 'react-helmet'
import { Link, graphql } from 'gatsby'
import Layout from '../components/Layout'
import Sidebar from '../components/sidebar'


class CatRoute extends React.Component {
  render() {
    const posts = this.props.data.allMarkdownRemark.edges
    const postLinks = posts.map((post) => (
      <li key={post.node.fields.slug}>
        <Link to={post.node.fields.slug}>
          <h2 className="is-size-2" style={{width: '100%', wordBreak:'break-word'}}>{post.node.frontmatter.title}</h2> 
          {post.node.frontmatter.featuredimage ? (
            <img src={ !!post.node.frontmatter.featuredimage.childImageSharp ? post.node.frontmatter.featuredimage.childImageSharp.fluid.src : post.node.frontmatter.featuredimage} alt= {post.node.frontmatter.title} width="100%" />
            ) : 
            null
            }     
        
        </Link>
        <p style={{width: '100%', fontWeight: 'bold', color: '#3571B8'}}> Date Published: {post.node.frontmatter.date}</p>
        <p style={{width: '100%', marginTop: '2rem'}}>{post.node.excerpt}</p>
        <br />
      </li>
    ))
    const cat = this.props.pageContext.cat
    const title = this.props.data.site.siteMetadata.title
    const totalCount = this.props.data.allMarkdownRemark.totalCount
    const catHeader = `${totalCount} post${
      totalCount === 1 ? '' : 's'
    } categorized under “${cat}”`

    return (
      <Layout>
        <section className="section">
          <Helmet title={`${cat} | ${title}`} />
          <div className="container">
            <div className="columns">
                
                <div class="tile is-ancestor">
                    <div class="tile is-vertical is-8">
                        <div class="tile">
                        
                        <div class="tile is-parent">
                            <article class="tile is-child box">
                            <div className="content">
             
                                <div
                                    className="column is-10 is-offset-1"
                                    style={{ marginBottom: '6rem' }}
                                >
                                    <h3 className="title is-size-4 is-bold-light">{catHeader}</h3>
                                    <ul className="catlist">{postLinks}</ul>
                                    <p>
                                    <Link to="/category/">Browse all categories</Link>
                                    </p>
                                </div>
                            </div>
                            </article>
                        </div>
                        </div>
                        
                    </div>
                    <div><Sidebar /></div>
                    </div> 
        </div>  
          </div>
        </section>
      </Layout>
    )
  }
}

export default CatRoute

export const catPageQuery = graphql`
  query CatPage($cat: String) {
    site {
      siteMetadata {
        title
      }
    }

    allMarkdownRemark(
      limit: 1000
      sort: { fields: [frontmatter___date], order: DESC }
      filter: { frontmatter: { category: { in: [$cat] } } }
    ) {
      totalCount
      edges {
        node {
          excerpt(pruneLength: 400)  
          fields {
            slug
          }
          frontmatter {
            date(formatString: "DD MMMM YYYY")
            title
            featuredimage {
                childImageSharp {
                  fluid(maxWidth: 1200, quality: 100) {
                    ...GatsbyImageSharpFluid
                    src
                  }
                }
              }
          }
        }
      }
    }
  }
`