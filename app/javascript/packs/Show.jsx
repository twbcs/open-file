import React, { Component } from 'react'
import "babel-polyfill"

export default class Show extends Component {
  state = {
    id: null,
    name: '',
    dir_name: '',
    tag_list: [],
    image: '',
    files: [],
    all_tag_list: [],
  }

  componentDidMount() {
    (async () => {
      const data = await fetch(`/${this.props.target}/${this.props.select}.json`, {
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
        const data = await fetch(`/${this.props.target}/${nextProps.select}.json`, {
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

  renderFileList = () => {
    return this.state.files.map((file, index) => {
      return (
        <div key={`file_${index}`}>
          <a className="btn btn-primary btn-sm mr-1 mb-1" data-remote="true" href={`/${this.props.target}/${this.state.id}/run?file=${file.name}`}>執行</a>
          {file.name}
          <div className="rating show ml-1" data-rating={file.rating} id={`rating-${index}`}>
            {file.rating != null ? this.renderRating(file.rating) : null}
          </div>
          {file.tag_list != [] ? this.renderTag(file.tag_list) : null}
        </div>
      )
    })
  }

  renderRating = (rating) => {
    return [1,3,5,7,9].map((star, index) => {
      return (
        <div className="star" key={`rating_${index}`}>
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
        <div className="row">
          <div className="col-lg-5 col-xl-5">
            <a className="btn btn-primary btn-sm mr-1" data-remote="true" href={`/${this.props.target}/${this.state.id}/run`}>
              <i className="fas fa-folder-open"></i> 開啟
            </a>
            名稱：{this.state.name}
            <a className="btn btn-primary btn-sm ml-1" data-remote="true" href={`/manager/${this.props.target}/${this.state.id}/edit`}>
              <i className="fas fa-edit"></i> 修改
            </a>
            <a className="btn btn-primary btn-sm ml-1" data-remote="true" href={`/manager/${this.props.target}/${this.state.id}`}>
              <i className="fas fa-edit"></i> 管理
            </a>
            <div className='tag_list'>
              {this.state.tag_list != [] ? this.renderTag(this.state.tag_list) : null}
            </div>
            <div className='tag_list'>
              {this.state.all_tag_list != [] ? this.renderTag(this.state.all_tag_list) : null}
            </div>
            <div className='image'>
              <img src={this.state.image}/>
            </div>
          </div>
          <div className="col-lg-7 col-xl-7">
            {this.renderFileList()}
          </div>
        </div>
      </div>
    )
  }
}
