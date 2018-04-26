import React, { Component } from 'react'
import "babel-polyfill"

export default class Show extends Component {
  state = {
    id: null,
    name: '',
    dir_name: '',
    tag_list: [],
    image: '',
    tag_list: [],
    files: [],
    all_tag_list: [],
  }

  componentDidMount() {
    (async () => {
      const data = await fetch(`http://localhost:3000/authors/${this.props.select}.json`, {
        method: 'GET', headers: {
          'Accept': 'application/json'
        }
      }).then((res) => res.json())
      console.log(data)
      this.setState({
        id: data.id, name: data.name, dir_name: data.dir_name, all_tag_list: data.all_tag_list,
        files: data.files, tag_list: data.tag_list, image: data.image })
    })()
  }

  componentWillReceiveProps(nextProps) {
    if (nextProps.select !== this.props.select) {
      (async () => {
        const data = await fetch(`http://localhost:3000/authors/${nextProps.select}.json`, {
          method: 'GET', headers: {
            'Accept': 'application/json'
          }
        }).then((res) => res.json())
        console.log(data)
        this.setState({
          id: data.id, name: data.name, dir_name: data.dir_name, all_tag_list: data.all_tag_list,
          files: data.files, tag_list: data.tag_list, image: data.image })
      })()
    }
  }

  renderList = () => {
    return this.state.files.map((file, index) => {
      return (
        <div key={`file_${index}`}>
          {file.name}
          <div className="rating show" data-rating={file.rating} id={`rating-${index}`}>
            {file.rating ? this.renderRating(file.rating) : null}
          </div>
        </div>
      )
    })
  }

  renderRating = (rating) => {
    return [1,3,5,7,9].map((star, index) => {
      return (
        <div class="star">
          <a>
            <div className={rating >= star ? 'star-left hover' : 'star-left'} data-star={star}></div>
          </a>
          <a>
            <div className={rating >= star + 1 ? 'star-right hover' : 'star-right'} data-star={star + 1}></div>
          </a>
        </div>
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
        <i class="fas fa-times index-times" onClick={this.onClick}></i>
        <div className="row">
          <div className="col-lg-5 col-xl-5">
            <div>名稱：{this.state.name}</div>
            <div className='tag_list'>{this.state.tag_list}</div>
            <div className='tag_list'>{this.state.all_tag_list}</div>
            <div className='image'>
              <img src={this.state.image}/>
            </div>
          </div>
          <div className="col-lg-7 col-xl-7">
            {this.renderList()}
          </div>
        </div>
      </div>
    )
  }
}
