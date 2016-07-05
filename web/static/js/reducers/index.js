import { combineReducers } from 'redux';
import CaveIndex from './cave_index';
import CaveShow from './cave_show';

const rootReducer = combineReducers({
  caves: CaveIndex,
  cave: CaveShow
});

export default rootReducer;
