import React, { Component } from 'react'
import ItemList from './ItemList'
import Show from './Show'
import "babel-polyfill"


export default class App extends Component {
  state = {
    list: [],
    select: null,
  }

  handleClick = (e) => {
    console.log(e)
    this.setState({
      select: e.select,
    })
  }

  componentDidMount() {
    (async () => {
      const data = await fetch(`http://localhost:3000/authors.json`, {
        method: 'GET', headers: {
          'Accept': 'application/json'
        }
      }).then((res) => res.json())
      console.log(data)
      this.setState({ list: data })
    })()
  }

  render() {
    return (
      <React.Fragment>
      <div className='list'>
        <ItemList {...this.state} handleClick={(e) => this.handleClick(e)} />
      </div>

        { this.state.select !== null ? <Show select={this.state.list[this.state.select].id} onClick={(e) => this.handleClick(e)}/> : null}
      </React.Fragment>
    )
  }
}
