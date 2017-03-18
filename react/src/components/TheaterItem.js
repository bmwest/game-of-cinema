import React from 'react';

const TheaterListItem = (props) => {

  return(
    <div>
      <h4 className="theater-list-item"><a href={`https://game-of-cinema.herokuapp.com/theaters/` + props.id}>{props.name}</a> | added by: {props.creator}</h4>
    </div>
  )
}

export default TheaterListItem;
