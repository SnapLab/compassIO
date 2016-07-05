import React from 'react'
import { Link } from 'react-router'

export default React.createClass({
  render() {
    return (
      <div className="container">
        <header className="header">
          <nav role="navigation">
            <ul className="nav nav-pills pull-right">
              <li><Link to='/caves/'>My Caves</Link></li>
              <li><Link to='/caves/new'>New Cave</Link></li>
            </ul>
          </nav>
        </header>

        <main role="main">
          {this.props.children}
        </main>
      </div>
    )
  }
})
