import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';
import TheaterList from './components/TheaterList.js';

$(function() {
  ReactDOM.render(
    <TheaterList />,
    document.getElementById('theater-list')
  );
});
