import React from 'react'

import Sidebar from '../../components/sidebar'
import Layout from '../../components/Layout'
import BlogRoll from '../../components/BlogRoll'


export default class BlogIndexPage extends React.Component {
  render() {
    return (
      <Layout>
        <div
          className="full-width-image-container margin-top-0"
          style={{
            backgroundImage: `url('/img/blogging.jpg')`,
          }}
        >
          <h1
            className="has-text-weight-bold is-size-1"
            style={{
              boxShadow: '0.5rem 0 0 #3571B8, -0.5rem 0 0 #3571B8',
              backgroundColor: '#3571B8',
              color: 'white',
              padding: '1rem',
            }}
          >
            Latest Articles
          </h1>
        </div>
        <section className="section">
          <div className="container">
          <div class="tile is-ancestor">
          <div class="tile is-vertical is-8">
            <div class="tile">              
              <div class="tile is-parent">
                <article class="tile is-child box">
                <div className="content">
                <BlogRoll />
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
  }
}
