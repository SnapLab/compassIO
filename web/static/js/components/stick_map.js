import React, { Component } from "react";
import { connect } from 'react-redux';
import { fetchCave } from '../actions/index';

export default class StickMap extends React.Component {
  componentWillMount() {
    this.props.fetchCave();
  }

  render() {
    const cave = this.props.cave;

    if (!cave) {
      return <div>Loading...</div>
    }
    return (
      <div>
        <h2>{cave.name}</h2>
      </div>
    );
  }
}

function mapStateToProps(state) {
  return { cave: state.cave.cave };
}

export default connect(mapStateToProps, { fetchCave })(StickMap);

