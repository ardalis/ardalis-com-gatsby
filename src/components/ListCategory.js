import React from 'react'
import { kebabCase } from 'lodash'
import { Link, graphql } from 'gatsby'
import Layout from './Layout'

const ListCategory = ({
  data: {
    allMarkdownRemark: { group },
 },
}) => (
  <Layout>
    <section className="section">      
      <div className="container content">
        <div className="columns">
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
      </div>
    </section>
  </Layout>
)

export default ListCategory

export const catlistPageQuery = graphql`
  query ListCatsQuery { 
    allMarkdownRemark(limit: 1000) {
      group(field: frontmatter___category) {
        fieldValue
        totalCount
      }
    }
  }
`
