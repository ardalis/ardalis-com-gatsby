import React from 'react'
import author from '../img/steve-smith-ardalis-200x200.jpg'
import book from '../img/Architecture-eBook-Cover-242x300.png';
import '../components/style.css'
import RecentPosts from './RecentPosts';


const Sidebar = () => (
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
                          <h3>Software Engineer</h3>
                          <p class="bio">Steve is an experienced software architect and trainer, focusing currently on ASP.NET Core and Domain-Driven Design.</p>
                        </div>
                      </div>
                    </div>
                    </div>             
              </div> 
              <div><h4 style={{
                    padding: '8px',
                    marginLeft: '10px',
                    }}><a href="/tips">Sign up</a> to receive a free developer tip from Steve in your inbox every Wednesday.</h4><br /></div> 
              <div><h2 style={{
                    fontSize: '22px',
                    padding: '7px',
                    marginLeft: '15px',
                    fontWeight: 'BOLD',
                   }}>//ONLINE TRAINING</h2></div> <br />
              <div className="recent-post">
              <ul className="recent-post">
              <li><a href="/tips">ASP.NET Core Quick Start</a></li>  
              <li><a href="/tips">Domain-Driven Design Fundamentals</a></li>  
              <li><a href="/tips">Refactoring Fundamentals</a></li>  
              <li><a href="/tips">Kanban Fundamentals</a></li>  
              <li><a href="/tips">SOLID Principles of OO Design</a></li>  
              <li><a href="/tips">Pair Programming</a></li> 
              </ul>  
              </div> 

            <div><br /><h4 style={{
                    fontSize: '22px',
                    padding: '7px',
                    marginLeft: '15px',
                    fontWeight: 'BOLD',
                    }}>//FREE ARCHITECTURE EBOOK</h4><br />
            <center><img src={book} alt="book"/>
            <h4><a href="/tips">Get the Book!</a></h4></center>
            <br />
            
            <h1 style={{
                    fontSize: '22px',
                    padding: '7px',
                    marginLeft: '15px',
                    fontWeight: 'BOLD',
                    }}>//RECENT ARTICLES</h1>
            <br />
            <RecentPosts />
            <h1 style={{
                    fontSize: '22px',
                    padding: '7px',
                    marginLeft: '15px',
                    fontWeight: 'BOLD',
                    }}>//RECENT TWEETS</h1>
            <a class="twitter-timeline" data-width="400" data-height="800" data-theme="light" href="https://twitter.com/ardalis?ref_src=twsrc%5Etfw" data-chrome="noscrollbar">Tweets by ardalis</a> 
            <script async src="https://platform.twitter.com/widgets.js" charset="utf-8" type="text/javascript"></script>
           </div>
            <div>
            
            </div>
           </div>
            </article>
          </div>
</div>  
  
)


export default Sidebar