import * as React from 'react'
import { useStaticQuery, graphql } from 'gatsby'
import { useFlexSearch } from 'react-use-flexsearch'
import Layout from '../components/Layout';
import Sidebar from '../components/sidebar'


const SearchPage = () => {
  const queryData = useStaticQuery(graphql`
    query {
      localSearchPages {
        index
        store
      }
    }
  `)
  const index = queryData.localSearchPages.index
  const store = queryData.localSearchPages.store

  const [query, setQuery] = React.useState('')
  const results = useFlexSearch(query, index, store)

  return (
    <Layout title="Search the Site">    
    <section className="section">
      <div className="tile is-ancestor">
        <div className="tile is-vertical is-7">
          <div className="tile">
            
          <div className="tile is-parent">
              <article className="tile is-child box">
                <div className="container content">
                  <div className="columns">
                    <div className="column is-10 is-offset-1">
                      <main>    
                      <h1 className="title is-size-2 has-text-weight-bold is-bold-light">Search this site</h1>
                        <label>
                          <span>Search terms: </span>
                          <input
                            name="query"
                            value={query}
                            onChange={(event) => setQuery(event.target.value)}
                          />
                        </label>
                        <h2 className="is-size-2 has-text-weight-bold is-bold-light">Results</h2>
                        {results.length > 0 ? (
                          <ul>
                            {results.map((result) => (
                              <li><a href={result.slug} target="_blank" rel="noreferrer">{result.title}</a> - {result.description}</li>
                            ))}
                          </ul>
                        ) : (
                          <p>No results!</p>
                        )}
                      </main>
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
    </Layout>
  )
}

export default SearchPage