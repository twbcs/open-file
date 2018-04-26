import React, { Component } from 'react'
import Item from './Item'

export default class ItemList extends Component {
  state = {
    select: null,
  }

  handleClick = (e) => {
    this.props.handleClick({
      select: e.select,
    })
  }

  renderList = () => {
    return this.props.list.map((item, index) => {
      return (
        <Item item={item} key={`item_${index}`} index={index} onClick={(e) => this.handleClick(e)}/>
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
