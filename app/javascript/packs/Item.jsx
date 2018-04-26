import React, { Component } from 'react'

export default class Item extends Component {

  onClick = () => {
    this.props.onClick({
      select: this.props.index,
    })
  }

  componentDidMount() {
    console.log(this.props.index)
  }

  imageLink = (image) => {
    if (image != '') {
      return (
        <img src={image}/>
      )
    }
  }

  render() {
    return (
      <div onClick={this.onClick}>
        <div className='item' >
          <div className='name'>名稱: {this.props.item.name}</div>
          <div className='image'>
            {this.imageLink(this.props.item.image)}
          </div>
        </div>
      </div>
    )
  }
}
