import React from 'react'
import { navigate } from 'gatsby-link'
import Layout from '../../components/Layout'
import Sidebar from '../../components/sidebar'
import contactImage from '../../img/contact-steve-smith.jpg';

function encode(data) {
  return Object.keys(data)
    .map((key) => encodeURIComponent(key) + '=' + encodeURIComponent(data[key]))
    .join('&')
}

export default class Index extends React.Component {
  constructor(props) {
    super(props)
    this.state = { isValidated: false }
  }

  handleChange = (e) => {
    this.setState({ [e.target.name]: e.target.value })
  }

  handleSubmit = (e) => {
    e.preventDefault()
    const form = e.target
    fetch('/', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: encode({
        'form-name': form.getAttribute('name'),
        ...this.state,
      }),
    })
      .then(() => navigate(form.getAttribute('action')))
      .catch((error) => alert(error))
  }

  render() {
    return (
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
          backgroundColor: 'rgba(53, 113, 184, 0.59)',
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
                <h4>I’m easy to find online:</h4>
                <ul>
                <li><a href="https://twitter.com/ardalis">@ardalis on Twitter</a></li>
                <li><a href="http://about.me/stevenasmith">About.me</a></li>  
                <li><a href="https://ardalis.com/contact-us">Email</a></li>    
                </ul>
                <p>Feel free to send me an email directly. If you have a technical question, you may want to ask it on <a href="http://stackoverflow.com/">StackOverflow</a> and just email or tweet me the link.</p>
                <h1>Get in touch</h1>
                <form
                  name="contact"
                  method="post"
                  action="/contact-us/thanks/"
                  data-netlify="true"
                  data-netlify-honeypot="bot-field"
                  onSubmit={this.handleSubmit}
                >
                  {/* The `form-name` hidden field is required to support form submissions without JavaScript */}
                  <input type="hidden" name="form-name" value="contact" />
                  <div hidden>
                    <label>
                      Don’t fill this out:{' '}
                      <input name="bot-field" onChange={this.handleChange} />
                    </label>
                  </div>
                  <div className="field">
                    <label className="label" htmlFor={'name'}>
                      Your name
                    </label>
                    <div className="control">
                      <input
                        className="input"
                        type={'text'}
                        name={'name'}
                        onChange={this.handleChange}
                        id={'name'}
                        required={true}
                      />
                    </div>
                  </div>
                  <div className="field">
                    <label className="label" htmlFor={'email'}>
                      Email
                    </label>
                    <div className="control">
                      <input
                        className="input"
                        type={'email'}
                        name={'email'}
                        onChange={this.handleChange}
                        id={'email'}
                        required={true}
                      />
                    </div>
                  </div>
                  <div className="field">
                    <label className="label" htmlFor={'message'}>
                      Message
                    </label>
                    <div className="control">
                      <textarea
                        className="textarea"
                        name={'message'}
                        onChange={this.handleChange}
                        id={'message'}
                        required={true}
                      />
                    </div>
                  </div>
                  <div className="field">
                    <button className="button is-link" type="submit">
                      Send
                    </button>
                  </div>
                </form>
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



