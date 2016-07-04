import React, { Component } from "react";
import { connect } from 'react-redux';
import paper from "paper";
import { fetchCave } from '../actions/index';

export default class StickMap extends React.Component {
  componentWillMount() {
    this.props.fetchCave();
  }

  componentDidMount() {
    paper.setup('canvas');

    var group = new paper.Group
    var segments = [new paper.Point(0,0), new paper.Point(100, 100), new paper.Point(200, 100), new paper.Point(300, 100)];

    var path = new paper.Path(segments);

    path.strokeColor = 'red';
    group.addChild(path)
    // group.rotate(-90)

    var inner_canvas = new paper.Path.Rectangle({
      point: [50, 50],
      size: [400, 400]
    });
    group.fitBounds(inner_canvas.bounds)
    paper.view.draw();

  };

  render() {
    const cave = this.props.cave;

    if (!cave) {
      return <div>Loading...</div>
    }
    return (
      <div>
        <h2>{cave.name}</h2>
        <canvas id="canvas" width={500} height={500} style={{backgroundColor: 'black'}} />
      </div>
    );
  }
}

function mapStateToProps(state) {
  return { cave: state.cave.cave };
}

export default connect(mapStateToProps, { fetchCave })(StickMap);

