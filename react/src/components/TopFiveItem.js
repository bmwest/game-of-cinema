import React from 'react';

const TopFiveItem = (props) => {

  return(
    <div>
      <li className="TopFive"><a href={`https://game-of-cinema.herokuapp.com/theaters/` + props.id}>{props.name}</a> | reviews: {props.reviews} </li>
    </div>
  )
}

export default TopFiveItem;
