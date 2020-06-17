import React from 'react'
import { Link } from 'gatsby'
import github from '../img/github-icon.svg'
import logo from '../img/ardalis-logo_300x60.png'
import facebook from '../img/social/facebook.svg'
import twitter from '../img/social/twitter.svg'
import youtube from '../img/social/youtube.svg'
import linkedin from '../img/social/linkedin.svg'
/* eslint-disable */
const Navbar = class extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      active: false,
      navBarActiveClass: '',
    }
  }

  toggleHamburger = () => {
    // toggle the active boolean in the state
    this.setState(
      {
        active: !this.state.active,
      },
      // after state has been updated,
      () => {
        // set the class in state for the navbar accordingly
        this.state.active
          ? this.setState({
              navBarActiveClass: 'is-active',
            })
          : this.setState({
              navBarActiveClass: '',
            })
      }
    )
  }

  render() {
    return (
      <nav
        className="navbar is-transparent"
        role="navigation"
        aria-label="main-navigation"
      >
        <div className="container">
          <div className="navbar-brand">
            <Link to="/" className="navbar-item" title="Logo">
              <img src={logo} alt="Ardalis" style={{ width: '150px' }} />
            </Link>
            {/* Hamburger menu */}
            <div
              className={`navbar-burger burger ${this.state.navBarActiveClass}`}
              data-target="navMenu"
              role="button"
              tabIndex={0}
              onClick={() => this.toggleHamburger()}
            >
              <span />
              <span />
              <span />
            </div>
          </div>
          <div
            id="navMenu"
            className={`navbar-menu ${this.state.navBarActiveClass}`}
          >
            <div className="navbar-start has-text-centered">
              <Link className="navbar-item" to="/blog">
                Blog
              </Link>
              <Link className="navbar-item" to="/training-classes">
                Training
              </Link>
              <Link className="navbar-item" to="/mentoring">
                Mentoring
              </Link>
              <Link className="navbar-item" to="/tips">
                Dev Tips
              </Link>
              <Link className="navbar-item" to="/architecture-ebook">
                Architecture eBook
              </Link>
              <Link className="navbar-item" to="/tools-used">
                Tools Used
              </Link>
              <Link className="navbar-item" to="/contact-us">
                Contact
              </Link>
            </div>
            <div className="navbar-end has-text-centered">
            <a
                className="navbar-item"
                href="https://www.facebook.com/StevenAndrewSmith"
                target="_blank"
                rel="noopener noreferrer"
              >
                <span className="icon">
                  <img src={facebook} alt="facebook" />
                </span>
              </a>
            <a
                className="navbar-item"
                href="https://www.linkedin.com/in/stevenandrewsmith"
                target="_blank"
                rel="noopener noreferrer"
              >
                <span className="icon">
                  <img src={linkedin} alt="linkedin" />
                </span>
              </a> 
              <a
                className="navbar-item"
                href="https://twitter.com/ardalis"
                target="_blank"
                rel="noopener noreferrer"
              >
                <span className="icon">
                  <img src={twitter} alt="twitter" />
                </span>
              </a> 
              <a
                className="navbar-item"
                href="https://www.youtube.com/ardalis/"
                target="_blank"
                rel="noopener noreferrer"
              >
                <span className="icon">
                  <img src={youtube} alt="youtube" />
                </span>
              </a> 
              <a
                className="navbar-item"
                href="https://github.com/ardalis"
                target="_blank"
                rel="noopener noreferrer"
              >
                <span className="icon">
                  <img src={github} alt="Github" />
                </span>
              </a>
              

            </div>
          </div>
        </div>
      </nav>
    )
  }
}

export default Navbar
