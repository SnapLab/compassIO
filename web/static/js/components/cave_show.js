import React, { Component } from "react";
import { connect } from 'react-redux';
import { fetchCave } from '../actions/index';

export default class CaveShow extends React.Component {
  componentWillMount() {
    this.props.fetchCave(this.props.params.cave_id);
  }

  render() {
    const cave = this.props.cave;

    if (!cave) {
      return <div>Loading...</div>
    }
    return (
      <div>
        <h2>{cave.name}</h2>
        <svg>
          <circle cx={50} cy={50} r={10} fill="red" />
        </svg>
      </div>
    );
  }
}

function mapStateToProps(state) {
  return { cave: state.cave.cave };
}

export default connect(mapStateToProps, { fetchCave })(CaveShow);

