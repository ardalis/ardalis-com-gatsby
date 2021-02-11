import React from 'react'
import PropTypes from 'prop-types'
import { kebabCase } from 'lodash'
import { Helmet } from 'react-helmet'
import { graphql, Link } from 'gatsby'
import Layout from '../components/Layout'
import '../components/style.css'
import Content, { HTMLContent } from '../components/Content'
import author from '../img/steve-smith-ardalis-200x200.jpg'
import blogImage from '../img/blogging.jpg'
import defaultImage from '../img/default-post-image.jpg'
import Sidebar from '../components/sidebar'
import { DiscussionEmbed } from 'disqus-react'


export const BlogPostTemplate = ({
  content,
  contentComponent,
  description,
  featuredimage,
  id,
  slug,
  tags,
  category,
  title,
  helmet,
  isCmsPreview,
  date
}) => {
  const PostContent = contentComponent || Content
  const siteUrl = 'https://ardalis.com' + slug
  const disqusprops = {
    shortname: `ardalis`,
    config: {
      url: siteUrl,
      identifier: slug,
      title: title,
    },
  };
  console.log(disqusprops)

  return (

    <section className="section">
      <div
        className="full-width-image-container margin-top-0"
        style={{
          backgroundImage: `url(${blogImage})`,
        }}
      >

      </div>
      {helmet || ''}

      <div className="tile is-ancestor">
        <div className="tile is-vertical is-7">
          <div className="tile">

            <div className="tile is-parent">
              <article className="tile is-child box">
                <div className="container content">
                  <div className="columns">
                    <div className="column is-10 is-offset-1">
                      <h1 className="title is-size-2 has-text-weight-bold is-bold-light">
                        {title}
                      </h1>
                      <p style={{ width: '100%', fontWeight: 'bold', color: '#3571B8' }}> Date Published: {date}</p>
                      <p>
                        {featuredimage ? (
                          <img src={!!featuredimage.childImageSharp ? featuredimage.childImageSharp.fluid.src : featuredimage} alt={title} width="100%" />
                        ) :
                          <img src={defaultImage} alt={title} width="100%" />
                        }
                      </p>
                      <PostContent content={content} />
                      <span>{tags && tags.length ? (
                        <div style={{ marginTop: `2rem` }}>
                          <h4>Tags - <Link to="/tags/" style={{ fontSize: `1rem`, color: 'gray' }}>Browse all tags</Link></h4>
                          <ul className="taglist">
                            {tags.map((tag) => (
                              <li key={tag + `tag`}>
                                <Link to={`/tags/${kebabCase(tag)}/`}>{tag}</Link>
                              </li>
                            ))}
                          </ul>
                        </div>
                      ) : null}
                      </span>
                      <span>
                        {category && category.length ? (
                          <div style={{ marginTop: `1rem` }}>
                            <h4>Category -  <Link to="/category/" style={{ fontSize: `1rem`, color: 'gray' }}>Browse all categories</Link></h4>
                            <ul className="taglist">
                              {category.map((cat) => (
                                <li key={cat + `cat`}>
                                  <Link to={`/category/${kebabCase(cat)}/`}>{cat}</Link>
                                </li>
                              ))}
                            </ul>
                          </div>
                        ) : null}
                      </span>
                      <div className="content has-text-centered">
                        <div className="content-card">
                          <div className="card">
                            <div className="firstinfo"><img src={author} alt="Steve Smith" />
                              <div className="profileinfo">
                                <h1>About Ardalis</h1>
                                <h3>Software Architect</h3>
                                <p className="bio">Steve is an experienced software architect and trainer, focusing on code quality and Domain-Driven Design with .NET.</p>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div>
                        {isCmsPreview ? (
                          ''
                        ) : (
                            <DiscussionEmbed {...disqusprops} />
                          )}
                      </div>
                    </div>
                  </div>
                </div>
              </article>
            </div>
          </div>

        </div>
        <div><Sidebar /></div>
      </div>
    </section>
  )
}

BlogPostTemplate.propTypes = {
  content: PropTypes.node.isRequired,
  contentComponent: PropTypes.func,
  description: PropTypes.string,
  title: PropTypes.string,
  featuredimage: PropTypes.oneOfType([PropTypes.object, PropTypes.string]),
  helmet: PropTypes.object,
  date: PropTypes.string
}


const BlogPost = ({ data }) => {
  const { markdownRemark: post } = data


  return (
    <Layout>
      <BlogPostTemplate
        content={post.html}
        contentComponent={HTMLContent}
        description={post.frontmatter.description}
        helmet={
          <Helmet titleTemplate="%s | Blog">
            <title>{`${post.frontmatter.title}`}</title>
            <meta
              name="description"
              content={`${post.frontmatter.description}`}
            />
            {post.frontmatter.featuredimage ? (
              <meta name="image" content={`https://ardalis.com${post.frontmatter.featuredimage.childImageSharp.fluid.src}`} />) :
              <meta name="image" content={`https://ardalis.com${defaultImage}`} />
            }
            <meta property="og:type" content="blog" />
            <meta property="og:image:alt" content={`${post.frontmatter.title}`} />
            <meta property="og:locale" content="en_US" />
            {post.frontmatter.featuredimage ? (
              <meta property="og:image" content={`https://ardalis.com${post.frontmatter.featuredimage.childImageSharp.fluid.src}`} />) :
              <meta property="og:image" content={`https://ardalis.com${defaultImage}`} />
            }

            <meta property="og:title" content={`${post.frontmatter.title}`} />
            <meta property="og:description" content={`${post.frontmatter.description}`} />
            <meta property="og:url" content={`https://ardalis.com${post.fields.slug}`} />
            <meta property="og:site_name" content="https://ardalis.com" />
            <meta property="article:author" content="Ardalis" />
            <meta name="twitter:title" content={`${post.frontmatter.title}`} />
            <meta name="twitter:url" content={`https://ardalis.com${post.fields.slug}`} />
            <meta name="twitter:description" content={`${post.frontmatter.description}`} />
            <meta name="twitter:card" content="summary_large_image" />
            {post.frontmatter.featuredimage ? (
              <meta name="twitter:image" content={`https://ardalis.com${post.frontmatter.featuredimage.childImageSharp.fluid.src}`} />) :
              <meta name="twitter:image" content={`https://ardalis.com${defaultImage}`} />
            }
          </Helmet>
        }
        id={post.id}
        tags={post.frontmatter.tags}
        category={post.frontmatter.category}
        title={post.frontmatter.title}
        featuredimage={post.frontmatter.featuredimage}
        slug={post.fields.slug}
        date={post.frontmatter.date}

      />
    </Layout>
  )
}

BlogPost.propTypes = {
  data: PropTypes.shape({
    markdownRemark: PropTypes.object,
  }),
}

BlogPost.defaultProps = {
  featuredimage: './images/archive_expat_headerImage.png',
};
export default BlogPost

export const pageQuery = graphql`
  query BlogPostByID($id: String!) {
    markdownRemark(id: { eq: $id }) {
      id
      html
      fields {
        slug
      }
    frontmatter {
        date(formatString: "DD MMMM YYYY")
        title
        description
        tags
        category
        featuredimage {
          publicURL        
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
`
