import React, { Component } from 'react'
import "babel-polyfill"

function image_link(image) {
  if (image != '') {
    return (
      <img src={image}/>
    )
  }
}

export default class Item extends Component {
  state = {
    list: []
  }

  componentDidMount() {
    (async () => {
      const data = await fetch(`http://localhost:3000/${this.props.target}.json`, {
        method: 'GET', headers: {
          'Accept': 'application/json'
        }
      }).then((res) => res.json())
      console.log(data)
      this.setState({ list: data })
    })()
  }

  renderList = () => {
  return this.state.list.map((item, index) => {
    return (
      <a data-remote="true" href={item.url} key={`item_${index}`}>
        <div className='item' >
          <div className='name'>名稱: {item.name}</div>
          <div className='image'>
            {image_link(item.image)}
          </div>
        </div>
      </a>
    )
  })
}

  render() {
    return (
      <React.Fragment>
        {this.renderList()}
      </React.Fragment>
    )
  }
}
