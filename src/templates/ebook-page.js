import React from 'react'
import PropTypes from 'prop-types'
import { graphql } from 'gatsby'
import Layout from '../components/Layout'
import Content, { HTMLContent } from '../components/Content'
import Sidebar from '../components/sidebar'


export const BookPageTemplate = ({ image, title, content, contentComponent }) => {
  const PageContent = contentComponent || Content
  const imageSrc = image?.childImageSharp?.fluid?.src ?? image;

  return (
    <section className="section section--gradient">
        <div
      className="full-width-image-container margin-top-0"
      style={{
        backgroundImage: `url(${
          imageSrc
        })`,
      }}
    >
      <h2
        className="has-text-weight-bold is-size-1"
        style={{
          boxShadow: '0.5rem 0 0 #3571B8, -0.5rem 0 0 #3571B8',
          backgroundColor: 'rgba(53, 113, 184, 0.59)',
          color: 'white',
          padding: '1rem',
        }}
      >
        {title}
      </h2>
    </div>    
      <div className="container">
        <div className="columns">
        <div class="tile is-ancestor">
          <div class="tile is-vertical is-7">
            <div class="tile">            
              <div class="tile is-parent">
                <article class="tile is-child box">
                <div className="column is-10 is-offset-1">
                <div className="section">
                <h1 className="title is-size-3 has-text-weight-bold is-bold-light">
                    {title}
                </h1>
                <PageContent className="content" content={content} />
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
  )
}

BookPageTemplate.propTypes = {
  image: PropTypes.oneOfType([PropTypes.object, PropTypes.string]),
  title: PropTypes.string.isRequired,
  content: PropTypes.string,
  contentComponent: PropTypes.func,
}

const BookPage = ({ data }) => {
  const { markdownRemark: post } = data

  return (
    <Layout>
      <BookPageTemplate
        image={post.frontmatter.image}
        contentComponent={HTMLContent}
        title={post.frontmatter.title}
        content={post.html}
      />
    </Layout>
  )
}

BookPage.propTypes = {
  data: PropTypes.object.isRequired,
}

export default BookPage

export const bookPageQuery = graphql`
  query BookPage($id: String!) {
    markdownRemark(id: { eq: $id }) {
      html
      frontmatter {
        title
        image {
          childImageSharp {
            fluid(maxWidth: 526, quality: 92) {
              ...GatsbyImageSharpFluid
            }
          }
        } 
      }
    }
  }
`
