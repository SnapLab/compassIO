import React, { Component } from "react";
import { connect } from 'react-redux';
import { fetchCaves } from '../actions/index';
import { Link } from 'react-router'

class CaveIndex extends React.Component {
  componentWillMount() {
    this.props.fetchCaves();
  }

  renderCave(cave) {
    return(
      <li key={cave.id}>
        <Link to={`/caves/${cave.id}`}>
          <span className="pull-xs-right">{cave.name}</span>
        </Link>
      </li>
    )
  }

  render() {
    const caves = this.props.caves

    if (caves.length == 0) { return (<div>Loading...</div>) }

    return (
      <div>
        <h2>My Caves</h2>
        <ul>
        {caves.map(this.renderCave)}
        </ul>
      </div>
    );
  }
}

function mapStateToProps(state) {
  return { caves: state.caves.caves };
}

export default connect(mapStateToProps, { fetchCaves })(CaveIndex);

