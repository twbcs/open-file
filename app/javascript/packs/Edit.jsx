import React, { Component } from 'react'
import "babel-polyfill"

export default class Edit extends Component {
  state = {
    id: null,
    name: '',
    dir_name: '',
    tag_list: [],
    image: '',
    all_tag_list: [],
  }

  componentDidMount() {
    (async () => {
      const data = await fetch(`http://localhost:3000/${this.props.target}/${this.props.select}.json`, {
        method: 'GET', headers: {
          'Accept': 'application/json'
        }
      }).then((res) => res.json())
      console.log(data)
      this.setState({
        id: data.id, name: data.name, dir_name: data.dir_name, all_tag_list: data.all_tag_list,
        tag_list: data.tag_list, image: data.image })
    })()
  }

  componentWillReceiveProps(nextProps) {
    if (nextProps.select !== this.props.select) {
      (async () => {
        const data = await fetch(`http://localhost:3000/${this.props.target}/${nextProps.select}.json`, {
          method: 'GET', headers: {
            'Accept': 'application/json'
          }
        }).then((res) => res.json())
        console.log(data)
        this.setState({
          id: data.id, name: data.name, dir_name: data.dir_name, all_tag_list: data.all_tag_list,
          tag_list: data.tag_list, image: data.image })
      })()
    }
  }

  renderTag = (tags) => {
    return tags.map((tag, index) => {
      return (
        <a className="badge badge-primary ml-1" key={`tag_${index}`} style={{color: '#fff',}}>
          <i className="fas fa-tag"></i> {tag}
        </a>
      )
    })
  }

  onClick = () => {
    this.props.onClick({
      select: null,
    })
  }

  render() {
    return (
      <div id="area">
        <i className="fas fa-times index-times" onClick={this.onClick}></i>

      </div>
    )
  }
}
