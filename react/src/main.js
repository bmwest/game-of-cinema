import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';
import TheaterList from './components/TheaterList.js';
import ArticleList from './components/ArticleList.js';

// $(function() {
//   ReactDOM.render(
//     <TheaterList />,
//     document.getElementById('theater-list')
//   );
// });

$(function() {
  ReactDOM.render(
    <ArticleList />,
    document.getElementById('article-list')
  );
});
