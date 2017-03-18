import React from 'react';

const ArticleListItem = (props) => {

  return(
    <div className="article-item">
      <h3 className="article-info"><a href={props.url}>{props.title}</a></h3>
      <h4 className="article-info">{props.byline}</h4>
      <h5 className="article-info">{props.published}</h5>
      <img className="article-pic" src={props.image} />
      <p className="article-info">{props.abstract}</p>
    </div>
  )
}

export default ArticleListItem;
