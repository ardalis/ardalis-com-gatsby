import React from 'react'
import PropTypes from 'prop-types'
import { Link, graphql, StaticQuery } from 'gatsby'

class RecentPosts extends React.Component {
  render() {
    const { data } = this.props
    const { edges: posts } = data.allMarkdownRemark

    return (
      <div className="columns is-multiline">
        {posts &&
          posts.map(({ node: post }) => (
            <div key={post.id}>
              <article>
                <header>
                <div className="recent-post">
                <ul className="recent-post">
                <li>
                    <Link
                      to={post.fields.slug}
                    >
                      {post.frontmatter.title}
                    </Link>
                </li>  
              
                </ul>  
                </div> 
                </header>

              </article>
            </div>
          ))}
      </div>
    )
  }
}

RecentPosts.propTypes = {
  data: PropTypes.shape({
    allMarkdownRemark: PropTypes.shape({
      edges: PropTypes.array,
    }),
  }),
}

export default () => (
  <StaticQuery
    query={graphql`
      query RecentPostsQuery {
        allMarkdownRemark(
          sort: { order: DESC, fields: [frontmatter___date] }
          filter: { frontmatter: { templateKey: { eq: "blog-post" } } }
          limit: 5
        ) {
          edges {
            node {
              id
              fields {
                slug
              }
              frontmatter {
                title
                templateKey
                date(formatString: "DD MMMM YYYY")
              }
            }
          }
        }
      }
    `}
    render={(data, count) => <RecentPosts data={data} count={count} />}
  />
)
