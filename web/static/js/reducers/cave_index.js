import { FETCH_CAVES } from '../actions/types';

const INITIAL_STATE = { caves: [] };

export default function(state = INITIAL_STATE, action) {
  switch(action.type) {
    case FETCH_CAVES:
      return Object.assign({}, state, {
        caves: action.payload.data
      })
    default:
      return state;
  }
}
