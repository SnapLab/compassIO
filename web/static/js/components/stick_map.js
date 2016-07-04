import React from "react";
import Paper from "paper";

export default class StickMap extends React.Component {
  componentDidMount() {

    paper.setup('canvas');
    var path = new paper.Path();
    // Give the stroke a color
    path.strokeColor = 'red';
    var start = new paper.Point(100, 100);
    // Move to start and draw a line from there
    path.moveTo(start);
    // Note that the plus operator on Point objects does not work
    // in JavaScript. Instead, we need to call the add() function:
    path.lineTo(start.add([ 200, -50 ]));
    // Draw the view now:
    paper.view.draw();

    }

    render() {
      return (
        <canvas id="canvas" width={600} height={600}/>
      );
    }
}

