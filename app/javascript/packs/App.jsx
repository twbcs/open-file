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
      const data = await fetch(`/${this.props.target}.json`, {
        method: 'GET', headers: {
          'Accept': 'application/json'
        }
      }).then((res) => res.json())
      console.log(data)
      this.setState({ list: data })
    })()
  }

  componentWillUnmount() {
    this.setState({ list: [], select: null })
  }

  render() {
    return (
      <React.Fragment>
      <div className='list'>
        <ItemList {...this.state} handleClick={(e) => this.handleClick(e)} />
      </div>

        { this.state.select !== null ? <Show select={this.state.list[this.state.select].id} target={this.props.target} onClick={(e) => this.handleClick(e)}/> : null}
      </React.Fragment>
    )
  }
}
