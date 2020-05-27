import React from 'react'
import { kebabCase } from 'lodash'
import { Helmet } from 'react-helmet'
import { Link, graphql } from 'gatsby'
import Layout from '../../components/Layout'
import Sidebar from '../../components/sidebar'


const CatPage = ({
  data: {
    allMarkdownRemark: { group },
    site: {
      siteMetadata: { title },
    },
  },
}) => (
  <Layout>
    <section className="section">
      <Helmet title={`Categories | ${title}`} />
      <div className="container">
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
                                        <h1 className="title is-size-2 is-bold-light">Categories</h1>
                                        <ul className="catlist">
                                        {group.map((cat) => (
                                            <li key={cat.fieldValue}>
                                            <Link to={`/category/${kebabCase(cat.fieldValue)}/`}>
                                                {cat.fieldValue} ({cat.totalCount})
                                            </Link>
                                            </li>
                                        ))}
                                        </ul>
                        </div>
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

export default CatPage

export const catPageQuery = graphql`
  query CatsQuery {
    site {
      siteMetadata {
        title
      }
    }
    allMarkdownRemark {
      group(field: frontmatter___category) {
        fieldValue
        totalCount
      }
    }
  }
`
