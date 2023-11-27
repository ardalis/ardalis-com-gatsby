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
                <div className="sidebar">
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
                  <div>
                  <a href="/search"><h2 style={{
                      fontSize: '22px',
                      padding: '7px',
                      marginLeft: '15px',
                      fontWeight: 'BOLD',
                    }}><span role="img" aria-label="magnifying glass">🔍</span> SEARCH</h2></a>
                  </div>
                  <div>
                    <h2 style={{
                      fontSize: '22px',
                      padding: '7px',
                      marginLeft: '15px',
                      fontWeight: 'BOLD',
                    }}><span role="img" aria-label="graduation cap">🎓</span> ONLINE TRAINING</h2></div> <br />
                  <div className="recent-post">
                    <ul className="recent-post">
                      <li><a href="https://www.pluralsight.com/courses/working-c-sharp-generics-best-practices">Working with C# Generics: Best Practices</a> NEW!</li>
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
                    <br /><h1 style={{
                      fontSize: '22px',
                      padding: '7px',
                      marginLeft: '15px',
                      fontWeight: 'BOLD',
                    }}><span role="img" aria-label="bird">🐦</span> RECENT TWEETS</h1>
                    <a className="twitter-timeline" data-width="400" data-height="800" data-theme="light" href="https://twitter.com/ardalis?ref_src=twsrc%5Etfw" data-chrome="noscrollbar">Tweets by ardalis</a>
                    <script async src="https://platform.twitter.com/widgets.js" charSet="utf-8" type="text/javascript"></script>
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
