import React from 'react'
import Layout from '../../components/Layout'
import Sidebar from '../../components/sidebar'
import contactImage from '../../img/contact-steve-smith.jpg';


export default () => (
  <Layout>
     <div
      className="full-width-image-container margin-top-0"
      style={{
        backgroundImage: `url(${ contactImage })`,
      }}
    >
      <h2
        className="has-text-weight-bold is-size-1"
        style={{
          boxShadow: '0.5rem 0 0 #3571B8, -0.5rem 0 0 #3571B8',
          backgroundColor: '#3571B8',
          color: 'white',
          padding: '1rem',
        }}
      >
        Contact Steve
      </h2>
    </div>
    <section className="section">
      <div className="container">   
      <div class="tile is-ancestor">
          <div class="tile is-vertical is-8">
            <div class="tile">
              
              <div class="tile is-parent">
                <article class="tile is-child box">
                <div className="content">
          <h1>Thank you!</h1>
          <p>I will get in touch soon</p>

          <h4>For urgent queries find me online:</h4>
                <ul>
                <li><a href="https://twitter.com/ardalis">@ardalis on Twitter</a></li>
                <li><a href="http://about.me/stevenasmith">About.me</a></li>  
                <li><a href="https://ardalis.com/contact-us">Email</a></li>    
                </ul>
                <p>Feel free to send me an email directly. If you have a technical question, you may want to ask it on <a href="http://stackoverflow.com/">StackOverflow</a> and just email or tweet me the link.</p>
                
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
