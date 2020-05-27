import React from 'react'
import PropTypes from 'prop-types'
import PreviewCompatibleImage from '../components/PreviewCompatibleImage'

const ReactMarkdown = require('react-markdown/with-html')

const FeatureGrid = ({ gridItems }) => (
  <div className="columns is-multiline">
    {gridItems.map((item) => (
      <div key={item.text} className="column is-6">
        <section className="section">
          <div className="has-text-centered">
          <h1 className="has-text-centered" style={{
                fontSize: '28px',
                padding: '7px',
              }}><strong>{item.blurbsheading}</strong></h1>
            <div
              style={{
                width: '240px',
                display: 'inline-block',
              }}
            >
              <PreviewCompatibleImage imageInfo={item} />
            </div>
          </div>
         
          <p><ReactMarkdown
            source={item.text}
            escapeHtml={false}
          /></p>
        </section>
      </div>
    ))}
  </div>
)

FeatureGrid.propTypes = {
  gridItems: PropTypes.arrayOf(
    PropTypes.shape({
      image: PropTypes.oneOfType([PropTypes.object, PropTypes.string]),
      text: PropTypes.string,
      blurbsheading: PropTypes.string,
    })
  ),
}

export default FeatureGrid
