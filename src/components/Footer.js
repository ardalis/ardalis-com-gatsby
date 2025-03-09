import React from 'react'
import './style.css';
import logo from '../img/ardalis-icon-128x128.png'
import facebook from '../img/social/facebook.svg'
import bluesky from '../img/social/bluesky.svg'
import youtube from '../img/social/youtube.svg'
import github from '../img/social/github.svg'
import linkedin from '../img/social/linkedin.svg'

const Footer = class extends React.Component {
  render() {
    return (
      <footer className="footer has-background-black has-text-white-ter">

        <div className="content has-text-centered has-background-black has-text-white-ter">
          <div className="container has-background-black has-text-white-ter">
            <div className="columns">
              <div className="column is-4">
                <form action="https://www.google.com/search" method="get">
                  <input type="hidden" name="q" value="site:ardalis.com" />
                  <input type="text" name="q" alt="search" className="googletextbox" />
                  <input type="submit" value="Search my Site with Google" className="googletextbox" />
                </form>
                <br />
                <a href="/interviews/">Interviews</a><br />
                <a href="/contact">Contact</a>
              </div>
              <div className="column is-4">
                <div className="content has-text-centered">
                  <img
                    src={logo}
                    alt="Ardalis"
                    style={{ width: '5em', height: '5em' }}
                  />
                  <p>Copyright © 2024</p><br />
                </div>
              </div>
              <div className="column is-4 social">

              <a title="bluesky" href="https://bsky.app/profile/ardalis.com">
                  <img
                    className="fas fa-lg"
                    src={bluesky}
                    alt="BlueSky"
                    style={{ width: '1em', height: '1em' }}
                  />
                </a>
                <a title="facebook" href="https://www.facebook.com/StevenAndrewSmith">
                  <img
                    src={facebook}
                    alt="Facebook"
                    style={{ width: '1em', height: '1em' }}
                  />
                </a>
                <a title="linkedin" href="https://www.linkedin.com/in/stevenandrewsmith">
                  <img
                    src={linkedin}
                    alt="Linkedin"
                    style={{ width: '1em', height: '1em' }}
                  />
                </a>
                <a title="youtube" href="https://www.youtube.com/ardalis/">
                  <img
                    src={youtube}
                    alt="YouTube"
                    style={{ width: '1em', height: '1em' }}
                  />
                </a>
                <a title="github" href="https://github.com/ardalis">
                  <img
                    src={github}
                    alt="GitHub"
                    style={{ width: '1em', height: '1em' }}
                  />
                </a>
              </div>
            </div>
            <div className="columns">
              <div className="column is-12"> <br />
              </div>
            </div>
          </div>
        </div>

      </footer>
    )
  }
}

export default Footer
