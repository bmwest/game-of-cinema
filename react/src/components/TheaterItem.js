import React from 'react';

const TheaterListItem = (props) => {

  return(
    <div className="list-item text-center small-4 columns">
      <h4><a href={`http://localhost:3000/theaters/` + props.id}>{props.name}</a></h4>
    </div>
  )
}

export default TheaterListItem;
