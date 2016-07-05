// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

import React from "react";
import ReactDOM from "react-dom";
import { Provider } from 'react-redux';
import { createStore, applyMiddleware } from 'redux';
import ReduxPromise from 'redux-promise';
import { Router, Route, browserHistory, IndexRoute } from 'react-router'

import reducers from './reducers';
import App from './components/app'
import CaveShow from "./components/cave_show";
import CaveNew from "./components/cave_new";
import CaveIndex from "./components/cave_index";

const createStoreWithMiddleware = applyMiddleware(ReduxPromise)(createStore);

var map_container = document.getElementById('react-container');

if (map_container) {
  ReactDOM.render(
  <Provider store={createStoreWithMiddleware(reducers)}>
    <Router history={browserHistory}>
      <Route path="/" component={App}>

        <IndexRoute component={CaveIndex} />

        <Route path="/cave/:cave_id" component={CaveShow} />
        <Route path="/caves/new" component={CaveNew} />
        <Route path="/caves/" component={CaveIndex} />

      </Route>
    </Router>
  </Provider>
  , map_container);
}
