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
        backgroundImage: `url(${ blogImage })`,
      }}
    >
      
    </div>
      {helmet || ''}
 
      <div class="tile is-ancestor">
          <div class="tile is-vertical is-8">
            <div class="tile">
              
              <div class="tile is-parent">
                <article class="tile is-child box">
                <div className="container content">
        <div className="columns">
          <div className="column is-10 is-offset-1">
            <h1 className="title is-size-2 has-text-weight-bold is-bold-light">
              {title}
            </h1>
            <p style={{width: '100%', fontWeight: 'bold', color: '#3571B8'}}> Date Published: {date}</p>
            <p>
            {featuredimage ? (
            <img src={ !!featuredimage.childImageSharp ? featuredimage.childImageSharp.fluid.src : featuredimage} alt= {title} width="100%" />
            ) : 
            <img src={defaultImage} alt= {title} width="100%" />
            }     
            </p>
            <PostContent content={content} />
            <p>{tags && tags.length ? (
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
            </p>
            <p>
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
            </p>
              <div className="content has-text-centered">
        <div class="content-card">
        <div class="card">
          <div class="firstinfo"><img src={author} alt="Steve Smith"/>
            <div class="profileinfo">
              <h1>About Ardalis</h1>
              <h3>Software Engineer</h3>
              <p class="bio">Steve is an experienced software architect and trainer, focusing currently on ASP.NET Core and Domain-Driven Design.</p>
            </div>
          </div>
        </div>
        </div>            
       </div>   
       <div>
       {isCmsPreview ? (
          ''
) : (
  <DiscussionEmbed
    shortname={disqusprops.shortname}
    config={disqusprops.config}
    />
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
