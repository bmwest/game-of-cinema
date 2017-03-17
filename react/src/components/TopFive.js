import React, { Component } from 'react';
import TopFiveItem from './TopFiveItem';

class TopFive extends Component {
  constructor(props) {
  super(props);
    this.state = {
      theaters: [],
    };
    this.getData = this.getData.bind(this);
  }

  getData() {
    fetch('https://game-of-cinema.herokuapp.com/api/v1/theaters.json')
      .then(response => {
        if (response.ok) {
          return response;
        } else {
          let errorMessage = `${response.status} ($response.statusText)`,
            error = new Error(errorMessage);
          throw(error);
        }
      })
      .then(response => {
        return response.json();
      })
      .then(body => {
        this.setState({theaters: body});
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`));
  }

  componentDidMount() {
    this.getData();
  }

  render() {
    let TopTheaters = this.state.theaters.sort(function(a, b) {
      return (a.reviews.length) - (b.reviews.length);
    });

    TopTheaters = TopTheaters.reverse();
    TopTheaters = TopTheaters.slice(0,5);
    let TopFive = TopTheaters.map((theater, index) => {
      return (
        <TopFiveItem
          id={theater.id}
          key={index}
          name={theater.name}
          reviews={theater.reviews.length}
        />
      )
    });

    return(
      <div className="TopTheaters">
        <ol>
          {TopFive}
        </ol>
      </div>
    )
  }
};

export default TopFive;
