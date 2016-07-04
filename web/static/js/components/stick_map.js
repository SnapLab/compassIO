import React, { Component } from "react";
import { connect } from 'react-redux';
import Paper from "paper";
import { fetchCave } from '../actions/index';

export default class StickMap extends React.Component {
  componentWillMount() {
    this.props.fetchCave();
  }

  // componentDidMount() {
  //   paper.setup('canvas');
  //   var path = new paper.Path();
  //   // Give the stroke a color
  //   path.strokeColor = 'red';
  //   var start = new paper.Point(100, 100);
  //   // Move to start and draw a line from there
  //   path.moveTo(start);
  //   // Note that the plus operator on Point objects does not work
  //   // in JavaScript. Instead, we need to call the add() function:
  //   path.lineTo(start.add([ 200, -50 ]));
  //   // Draw the view now:
  //   paper.view.draw();

  //   }


  render() {
    const cave= this.props.cave;
    if (!cave) {
      return <div>Loading...</div>
    }
    return (
      <div>
      <h1>{cave.name}</h1>
      <canvas id="canvas" width={600} height={600}/>
      </div>
    );
  }
}

function mapStateToProps(state) {
  return { cave: state.cave.cave };
}

export default connect(mapStateToProps, { fetchCave })(StickMap);

