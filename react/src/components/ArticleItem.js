import React from 'react';

const ArticleListItem = (props) => {

  return(
    <div className="article-item">
      <h3><a href={props.url}>{props.title}</a></h3>
      <h4>{props.byline}</h4>
      <h5>{props.published}</h5>
      <img src={props.image} />
      <p>{props.abstract}</p>
    </div>
  )
}

export default ArticleListItem;
