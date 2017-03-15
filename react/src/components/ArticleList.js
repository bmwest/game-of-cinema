import React, { Component } from 'react';
import ArticleListItem from './ArticleItem';

class ArticleList extends Component {
  constructor(props) {
  super(props)
    this.state = {
      articles: [],
    };
    this.getData = this.getData.bind(this);
  }

  getData() {
    let url = "https://api.nytimes.com/svc/topstories/v2/movies.json";
    url += '?' + $.param({
      'api-key': "af71316ee1644ec48fe1d918f3187674"
    });

  fetch(url)
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
    debugger
    return response.json()
  })
  .then(body => {
    this.setState({articles: body.results});
  })
  .catch(error => console.error(`Error in fetch: ${error.message}`));
  }

  componentDidMount() {
    this.getData();
  }

  render() {
    let newArticles = this.state.articles.map((article, index) => {
      let dateConversion = new Date(article.published_date)
      let image_url;
      if (article.multimedia.length > 0) {
        image_url = article.multimedia[article.multimedia.length - 1].url
      } else {
        image_url = '../../app/assets/images/image-not-found.png'
      }

      return (
        <ArticleListItem
          key = {index}
          abstract = {article.abstract}
          byline = {article.byline}
          title = {article.title}
          url = {article.short_url}
          published = {dateConversion.toDateString()}
          image = {image_url}
        />
      )
    });
    return(
      <div className="article-index">
        <h1>Movie News!</h1>
        {newArticles}
        <h3><a href="https://www.nytimes.com/section/movies">More Articles!</a></h3>
      </div>
    )
  }
};

export default ArticleList;
