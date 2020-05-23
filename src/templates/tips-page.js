import React from 'react'
import PropTypes from 'prop-types'
import { graphql } from 'gatsby'
import Layout from '../components/Layout'
import Testimonials from '../components/Testimonials'
import Sidebar from '../components/sidebar'
import MailchimpForm from '../components/MailchimpForm'

export const TipsPageTemplate = ({
  image,
  title,
  heading,
  description,
  newsletterheading,
  headtestimonials,
  testimonials,

}) => (

    
  <div>
    <div
      className="full-width-image-container margin-top-0"
      style={{
        backgroundImage: `url(${
          !!image.childImageSharp ? image.childImageSharp.fluid.src : image
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
    <section className="section">
      <div className="container">
          <div className="columns">
            
          <div class="tile is-ancestor">
          <div class="tile is-vertical is-8">
            <div class="tile">
              
              <div class="tile is-parent">
                <article class="tile is-child box">
                <div className="content">

                <h1 className="has-text-weight-semibold is-size-2">{newsletterheading}</h1>
               <MailchimpForm />
            <h1 className="has-text-weight-semibold is-size-2">{heading}</h1>
            <p>{description}</p> 

            <h1 className="has-text-weight-semibold is-size-2">{headtestimonials}</h1>
              <Testimonials testimonials={testimonials} />  
              <h1>On Twitter</h1>       
              <div className="column is-10 is-offset-1">
              <a class="twitter-timeline" href="https://twitter.com/weeklydevtips/likes?ref_src=twsrc%5Etfw">Tweets Liked by @weeklydevtips</a> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
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
  </div>
)

TipsPageTemplate.propTypes = {
  image: PropTypes.oneOfType([PropTypes.object, PropTypes.string]),
  title: PropTypes.string,
  heading: PropTypes.string,
  description: PropTypes.string,
  newsletterheading: PropTypes.string,
  headtestimonials: PropTypes.string, 
  testimonials: PropTypes.array,
}

const TipsPage = ({ data }) => {
  const { frontmatter } = data.markdownRemark

  return (
    <Layout>
      <TipsPageTemplate
        image={frontmatter.image}
        title={frontmatter.title}
        heading={frontmatter.heading}
        description={frontmatter.description}
        newsletterheading={frontmatter.newsletterheading}
        headtestimonials={frontmatter.headingtestimonials}
        testimonials={frontmatter.testimonials}
      />
    </Layout>
  )
}

TipsPage.propTypes = {
  data: PropTypes.shape({
    markdownRemark: PropTypes.shape({
      frontmatter: PropTypes.object,
    }),
  }),
}

export default TipsPage

export const tipsPageQuery = graphql`
  query TipsPage($id: String!) {
    markdownRemark(id: { eq: $id }) {
      frontmatter {
        title
        image {
          childImageSharp {
            fluid(maxWidth: 526, quality: 92) {
              ...GatsbyImageSharpFluid
            }
          }
        } 
        heading
        newsletterheading
        description
        headingtestimonials
        testimonials {
          author
          quote
        }
      }
    }
  }
`
