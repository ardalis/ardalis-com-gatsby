import React from 'react'
import { kebabCase } from 'lodash'
import { Link } from 'gatsby'
import author from '../img/steve-smith-ardalis-200x200.jpg'
import book from '../img/Architecture-eBook-Cover-242x300.png';
import '../components/style.css'
import { StaticQuery, graphql } from "gatsby"
import RecentPosts from './RecentPosts';


export default function Sidebar() {
  return (
    <StaticQuery
      query={graphql`
        query HeadingQuery {
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
      `}
      render={data => (
        <header>

          <div>
            <div className="tile is-parent">
              <article className="tile is-child box">
                <div className="sidebar" id="sidebar">
                  <div className="content has-text-centered">
                    <div className="content-card">
                      <div className="card-sidebar">
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
                  <div style={{
                    padding: '8px',
                    marginLeft: '10px',
                  }}>
                    Get a <a href="/tips">Free Developer Tip</a> in your inbox every Wednesday.
                  </div>
                  {/* <div style={{
                    padding: '8px',
                    marginLeft: '10px',
                  }}>
                  <script async type="text/javascript" src="//cdn.carbonads.com/carbon.js?serve=CWYIE53N&placement=ardaliscom&format=cover" id="_carbonads_js"></script>
                  </div> */}
                  <div>
                    <a href="/search"><h2 style={{
                      fontSize: '22px',
                      padding: '7px',
                      marginLeft: '15px',
                      fontWeight: 'BOLD',
                    }}><span role="img" aria-label="magnifying glass">🔍</span> SEARCH</h2></a>
                  </div> <br />
                  <div>
                    <h2 style={{
                      fontSize: '22px',
                      padding: '7px',
                      marginLeft: '15px',
                      fontWeight: 'BOLD',
                    }}><span role="img" aria-label="graduation cap">🎓</span> ONLINE TRAINING</h2></div> <br />
                  <div className="recent-post">
                    <ul className="recent-post">
                      <li><a href="https://dometrain.com/bundle/from-zero-to-hero-modular-monoliths-in-dotnet/">From Zero to Hero: Modular Monoliths in .NET</a></li>
                      <li><a href="https://www.pluralsight.com/courses/refactoring-solid-c-sharp-code">Refactoring to SOLID C# Code</a> NEW!</li>
                      <li><a href="https://www.pluralsight.com/courses/aspdotnet-core-6-web-api-best-practices">ASP.NET Core 6 Web API: Best Practices</a></li>
                      <li><a href="https://www.pluralsight.com/courses/working-c-sharp-generics-best-practices">Working with C# Generics: Best Practices</a></li>
                      <li><a href="https://www.pluralsight.com/courses/fundamentals-domain-driven-design">Domain-Driven Design Fundamentals</a></li>
                      <li><a href="https://www.pluralsight.com/courses/refactoring-csharp-developers">Refactoring for C# Devs</a></li>
                      <li><a href="https://www.pluralsight.com/courses/kanban-getting-started">Kanban: Getting Started</a></li>
                      <li><a href="https://www.pluralsight.com/courses/csharp-solid-principles">SOLID Principles for C# Devs</a></li>
                      <li><a href="https://www.pluralsight.com/courses/design-patterns-overview">Design Patterns Overview</a></li>
                    </ul>
                  </div> <br />

                  <div className="recent-post">
                    <h2 style={{
                      fontSize: '22px',
                      padding: '7px',
                      fontWeight: 'BOLD',
                    }}><span role="img" aria-label="clipboard">📋</span> CATEGORIES</h2> <br />
                    <ul className="recent-post" style={{
                      textTransform: 'uppercase'
                    }}>
                      {data.allMarkdownRemark.group.map((cat) => (
                        <li key={cat.fieldValue}>
                          <Link to={`/category/${kebabCase(cat.fieldValue)}/`}>
                            {cat.fieldValue} ({cat.totalCount})
                          </Link>
                        </li>
                      ))}
                    </ul> </div>

                  <div>
                    <br />
                    <h4 style={{
                      fontSize: '22px',
                      padding: '7px',
                      marginLeft: '15px',
                      fontWeight: 'BOLD',
                    }}><span role="img" aria-label="book">📘</span> FREE ARCHITECTURE EBOOK</h4><br />
                    <center><a href="/architecture-ebook"><img src={book} alt="book" /></a>
                      <h4><a href="/architecture-ebook">Get the Book!</a></h4></center>



                    <br /><h1 style={{
                      fontSize: '22px',
                      padding: '7px',
                      marginLeft: '15px',
                      fontWeight: 'BOLD',
                    }}><span role="img" aria-label="pen">🖊️</span> RECENT ARTICLES</h1>
                    <br />
                    <RecentPosts />
                    <br />
                  </div>
                  <div>

                  </div>
                </div>
              </article>
            </div>
          </div>
        </header>


      )}
    />
  )

}
