import { combineReducers } from 'redux';
import CaveReducer from './reducer_cave';

const rootReducer = combineReducers({
  cave: CaveReducer
});

export default rootReducer;
