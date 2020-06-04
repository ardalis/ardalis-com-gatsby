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
            <div class="tile is-parent">
            <article class="tile is-child box">
            <div className="sidebar">
                        <div className="content has-text-centered">
                        <div class="content-card">
                        <div class="card-sidebar">
                          <div class="firstinfo"><img src={author} alt="Steve Smith"/>
                            <div class="profileinfo">
                              <h1>About Ardalis</h1>
                              <h3>Software Architect</h3>
                              <p class="bio">Steve is an experienced software architect and trainer, focusing on code quality and Domain-Driven Design with .NET.</p>
                            </div>
                          </div>
                        </div>
                        </div>             
                        </div> 
                    <div>
                    <h4 style={{
                    padding: '8px',
                    marginLeft: '10px',
                    }}><a href="/tips">Sign up</a> to receive a free developer tip from Steve in your inbox every Wednesday.</h4><br />
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
                    <li><a href="/tips">ASP.NET Core Quick Start</a></li>  
                    <li><a href="/tips">Domain-Driven Design Fundamentals</a></li>  
                    <li><a href="/tips">Refactoring Fundamentals</a></li>  
                    <li><a href="/tips">Kanban Fundamentals</a></li>  
                    <li><a href="/tips">SOLID Principles of OO Design</a></li>  
                    <li><a href="/tips">Pair Programming</a></li> 
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
                    <center><a href="/tips"><img src={book} alt="book"/></a>
                    <h4><a href="/tips">Get the Book!</a></h4></center>
                   
                    

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
                    <a class="twitter-timeline" data-width="400" data-height="800" data-theme="light" href="https://twitter.com/ardalis?ref_src=twsrc%5Etfw" data-chrome="noscrollbar">Tweets by ardalis</a> 
                    <script async src="https://platform.twitter.com/widgets.js" charset="utf-8" type="text/javascript"></script>
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
