//MailchimpForm.jsx
import addToMailchimp from "gatsby-plugin-mailchimp"
import TextField from "@material-ui/core/TextField"
import Button from "@material-ui/core/Button"
import { Typography } from "@material-ui/core"
import React from "react"

export default class MailChimpForm extends React.Component {
  constructor() {
    super()
    this.state = { email: "", result: null }
  }

  _handleSubmit = e => {
    e.preventDefault()
    addToMailchimp(this.state.email) 
      .then(data => {
      })
      .catch(() => {
      })
  }
  // 2. via `async/await`
  _handleSubmit = async e => {
    e.preventDefault()
    const result = await addToMailchimp(this.state.email)
    this.setState({result: result.result})
    
  }
handleChange = event => {
    this.setState({ email: event.target.value })
  }
render() {
    const isResult = this.state.result;
    console.log(isResult)
    return this.state.result === "success" ? (
      <div><h4>Thank you for subscribing!</h4></div>
    ) : this.state.result === "error" ? (
      <div><h4>Oops Something went wrong! <a href="/tips">Please try again</a></h4></div>
    ) : (

        <form onSubmit={this._handleSubmit}>
        <TextField
          id="outlined-email-input"
          label="Email"
          type="email"
          name="email"
          autoComplete="email"
          variant="outlined"
          onChange={this.handleChange}
        />
         <Button
          variant="contained"
          color="primary"
          label="Submit"
          type="submit"
        >
          <Typography variant="button">Sign Up</Typography>
        </Button>
      </form>
    )
  }
}