import { FETCH_CAVE } from '../actions/types';

const INITIAL_STATE = { cave: {} };

export default function(state = INITIAL_STATE, action) {

  switch(action.type) {
    case FETCH_CAVE:
      return Object.assign({}, state, {
        cave: action.payload.data.cave
      })
    default:
      return state;
  }
}
