import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';
import TheaterList from './components/TheaterList.js';
import ArticleList from './components/ArticleList.js';

$(function() {
  if (window.location.pathname == "/theaters") {
    ReactDOM.render(<TheaterList />, document.getElementById('theater-list'));
  } else if (window.location.pathname == "/") {
    ReactDOM.render( <ArticleList />, document.getElementById('article-list'));
  }
});
