import React, { Component } from 'react';
import TheaterListItem from './TheaterItem';

class TheaterList extends Component {
  constructor(props) {
  super(props)
    this.state = {
      theaters: [],
      currentPage: 1,
      theatersPerPage: 5
    };
    this.getData = this.getData.bind(this);
    this.handleClick = this.handleClick.bind(this);
  }

  handleClick(event) {
    this.setState({
      currentPage: Number(event.target.id)
    });
  }

  getData() {
    fetch('http://localhost:3000/api/v1/theaters.json')
      .then(response => {
        if (response.ok) {
          return response;
        } else {
          let errorMessage = `${response.status} ($response.statusText)`,
            error = new Error(errorMessage);
          throw(error);
        }
      })
      .then(response => response.json())
      .then(body => {
        this.setState({theaters: body});
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`));
  }

  componentDidMount() {
    this.getData();
  }

  render() {
    let indexOfLastTheater = this.state.currentPage * this.state.theatersPerPage;
    let indexOfFirstTheater = indexOfLastTheater - this.state.theatersPerPage;
    let currentTheaters = this.state.theaters.slice(indexOfFirstTheater, indexOfLastTheater);

    let newTheaters = currentTheaters.map((theater, index) => {
      return (
        <TheaterListItem
          id={theater.id}
          key={index}
          name={theater.name}
          creator={theater.user.first_name}
        />
      )
    });

    let pageNumbers = [];
    for (let i = 1; i <= Math.ceil(this.state.theaters.length / this.state.theatersPerPage); i++){
      pageNumbers.push(i);
    }

    let renderPageNumbers = pageNumbers.map(number => {
      return (
        <li
        key={number}
        id={number}
        onClick={this.handleClick}>

        {number}
        </li>
      );
    });

    return(
      <div className="theater-index">
        <h2>All Theaters</h2>
        {newTheaters}
        <ul>
          {renderPageNumbers}
        </ul>
      </div>
    )
  }
};

export default TheaterList;
