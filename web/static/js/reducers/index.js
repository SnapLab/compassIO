import { combineReducers } from 'redux';
import CaveIndex from './cave_index';
import CaveReducer from './reducer_cave';

const rootReducer = combineReducers({
  caves: CaveIndex,
  cave: CaveReducer
});

export default rootReducer;
